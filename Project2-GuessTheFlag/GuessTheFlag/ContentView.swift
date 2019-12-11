//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Chris on 14/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

// MARK: - Day 24 Challenge 3: Create a FlagImage() view
struct FlagImage: View {
    var flagName: String
    
    // Day 75 Accessibilty text for VoiceOver
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
            .accessibility(label: Text(self.labels[flagName] ?? "Unknown flag"))
    }
    
    init (_ flagName: String) {
        self.flagName = flagName
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    // Day 34 additional state properties
    // TODO: - Refactor to use custom button with rotation and scale state
    @State private var rotationAmount = [0.0, 0.0, 0.0]
    @State private var scaleAmount: [CGFloat] = [1.0, 1.0, 1.0]
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation(.easeOut(duration: 0.5)) {
                            self.flagTapped(number)
                        }
                    }) {
                        FlagImage(self.countries[number])
                    }
                    .animation(.easeIn(duration: 0.2))
                    .opacity(self.showingScore && number != self.correctAnswer ? 0.3 : 1.0)
                    .rotation3DEffect(.degrees(self.rotationAmount[number]), axis: (x:0, y:1, z:0))
                    .scaleEffect(self.scaleAmount[number])
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.black)
                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                    })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            rotationAmount[number] += 360
            scoreTitle = "Correct!"
            score += 1
        } else {
            scaleAmount[number] = 0.2
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            score -= 1
        }
        showingScore = true
    }
    
    func askQuestion() {
        scaleAmount = [1.0, 1.0, 1.0]
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
