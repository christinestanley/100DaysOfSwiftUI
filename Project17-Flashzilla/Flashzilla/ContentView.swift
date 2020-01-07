//
//  ContentView.swift
//  Flashzilla
//
//  Created by Chris on 18/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled
    
    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    
    @State private var isActive = true
    
    @State private var showingEditScreen = false
    @State private var showingSettingsScreen = false
    
    @State private var reuseFailedCards = true
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(
                        Capsule()
                            .fill(Color.black)
                            .opacity(0.75)
                )
                ZStack {
                    ForEach(0..<cards.count, id:\.self) { index in
                        CardView(card: self.cards[index]) { correct in
                            withAnimation {
                                self.removeCard(at: index, isCorrect: correct)
                            }
                        }
                        .stacked(at: index, in: self.cards.count)
                        .allowsHitTesting(index == self.cards.count - 1)
                        .accessibility(hidden: index < self.cards.count - 1)
                    }
                    .allowsHitTesting(timeRemaining > 0)
                    
                    
                    if timeRemaining == 0 {
                        Button("Times up...\nStart again?", action: resetCards)
                            .font(.largeTitle)
                            .padding(30)
                            .background(Color.gray)
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .transition(.move(edge: .bottom))
                    }
                }
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                    .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                    .clipShape(Capsule())
                }
                
            }
            
            VStack {
                HStack {
                    
                    Button(action: {
                        self.showingSettingsScreen = true
                    }) {
                        Image(systemName: "arrow.2.circlepath.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .sheet(isPresented: $showingSettingsScreen, onDismiss:
                    resetCards) {
                        SettingsView(retryWrongGuesses: self.$reuseFailedCards)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                    }
                    .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
                        EditCards()
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()
            
            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1, isCorrect: false)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1, isCorrect: true)
                            }
                        }) {
                        Image(systemName: "checkmark.circle")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                        }
                    .accessibility(label: Text("Correct"))
                    .accessibility(hint: Text("Mark your anwer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer){ _ in
            guard self.isActive else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            self.isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if self.cards.isEmpty == false {
                self.isActive = true
            }
        }
        
        
        .onAppear(perform: resetCards)
    }
    
    func removeCard(at index: Int, isCorrect: Bool) {
        guard index >= 0 else { return }
        
        let card = cards[index]
        if !isCorrect && reuseFailedCards == true {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.cards.insert(card, at: 0)
            }
        }
        
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}
