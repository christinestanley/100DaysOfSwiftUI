//
//  ContentView.swift
//  Dice
//
//  Created by Chris on 12/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var die1 = Die(sides: 6)
    @ObservedObject var die2 = Die(sides: 6)
    
    @State private var score: [[Int]] = []
    
    var body: some View {
        TabView{
            ZStack {
                // Photo by FWStudio from Pexels
                Image("wood")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .accessibility(hidden: true)
                
                VStack {
                    HStack {
                        DieView(die: die1)
                        .padding()
                        .accessibility(label: Text("\(die1.value)"))

                        DieView(die: die2)
                        .padding()
                        .accessibility(label: Text("\(die2.value)"))
                    }
                    
                    Button(action: {
                        self.die1.roll()
                        self.die2.roll()
                        self.saveScore()
                    }) {
                        Text("Roll")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .frame(width: 200, height: 200)
                            .accessibility(label: Text("Roll the dice"))
                    }
                }
            }
            .tabItem {
                Image(systemName: "6.square")
                Text("Roll")
            }
            
            NavigationView {
                List {
                    ForEach(score, id: \.self) { roll in
                        HStack {
                            Text("Roll ")
                            ForEach(roll, id: \.self) { score in
                                Image(systemName: "\(score).square")
                            }
                            Text("Score \(self.rollScore(roll))")
                        }
                        .font(.headline)
                        .accessibilityElement(children: .ignore)
                        .accessibility(label: Text("Rolled \(self.rollDescription(roll)) to score \(self.rollScore(roll))"))
                    }
                }
                .navigationBarTitle("Latest Rolls", displayMode: .inline)
            }
            .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Results")
            }
        }
    }
    
    // Accessibility voiceOver helpers
    func rollScore(_ roll: [Int]) -> Int {
        guard roll.count > 0 else { return 0 }
        
        return roll.reduce(0, +)
    }
    
    func rollDescription(_ roll: [Int]) -> String {
        guard roll.count > 0 else { return "nothing" }
        
        if roll.count == 1 { return String(roll[0]) }
        
        var description = ""
        for value in roll {
            description += " " + String(value)
        }
        return description
    }
    
    func saveScore() {
        score.insert([die1.value, die2.value], at: 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
