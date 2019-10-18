//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Chris on 18/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct RoundText: View {
    var text: String
    var tint: Color {
        switch text {
        case "Win":
            return .green
        case "Lose":
            return .red
        default:
            return .white
        }
    }
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .foregroundColor(.black)
            .padding(30)
            .background(tint)
            .clipShape(Circle())
    }
}

struct ContentView: View {
    @State private var currentChoice = 0
    @State private var shouldWin = true
    @State private var roundNumber = 1
    @State private var scoreText = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var resultTitle = ""
    @State private var resultMessage = ""


    private let weapon = ["💎", "🧻", "✂️"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Rock Paper Scissors")
                    .font(.largeTitle)
                
                Text("Round \(roundNumber)")
                    .fontWeight(.black)
                
                HStack {
                    RoundText(text: "\(weapon[currentChoice])")
                    if shouldWin {
                        RoundText(text: "Win")
                    } else {
                        RoundText(text: "Lose")
                    }
                }
                .opacity(showingScore ? 0.5 : 1)
                
                HStack {
                    ForEach(0..<weapon.count) { number in
                        Button(action: {
                            self.weaponTapped(number)
                        }) {
                            RoundText(text: "\(self.weapon[number])")
                        }
                    }
                }
                
                Text("Score: \(score)")
                
                Spacer()
            }
            .font(.title)
            .foregroundColor(.white)
            .alert(isPresented: $showingScore) {
                Alert(title: Text(resultTitle), message: Text(resultMessage), dismissButton: .default(Text("Continue")) {
                    self.nextRound()
                    })
            }
        }
    }
    
    func weaponTapped(_ number: Int) {
        var didWin = false
        switch number {
        case 0:
            if currentChoice == 2 { didWin = true }
        case 1:
            if currentChoice == 0 { didWin = true }
        default:
            if currentChoice == 1 { didWin = true }
        }
        
        didWin = shouldWin ? didWin : !didWin
        
        if didWin {
            resultTitle = "Yes! \(weapon[number]) \(shouldWin ? "beats" : "loses to") \(weapon[currentChoice])"
            resultMessage = "Score +1"
            score += 1
        } else {
            resultTitle = "No! \(weapon[number]) \(!shouldWin ? "beats" : "loses to") \(weapon[currentChoice])"
            if number == currentChoice {
                resultTitle = "Hmm! \(weapon[number]) matches  \(weapon[currentChoice])"
            }
            resultMessage = "Score -1"
            score -= 1
        }
        
        if roundNumber == 10 {
            resultMessage = "Final Score: \(score)"
        }
        
        showingScore = true
    }
    
    func nextRound() {
        roundNumber += 1
        if roundNumber > 10 {
            roundNumber = 1
            score = 0
        }
        
        currentChoice = Int.random(in: 0..<weapon.count)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
