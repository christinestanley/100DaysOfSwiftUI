//
//  ContentView.swift
//  TimesTable
//
//  Created by Chris on 28/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

enum GameState {
    case startGame
    case pickNumberQuestions
    case playGame
    case gameOver
}

struct ContentView: View {
    @State private var gameState: GameState = .startGame
    @State private var selectedTables = [Int]()
    @State private var numberOfQuestions = 5
    @State private var questions = [(Int, Int)]()
    @State private var enabled = false
    
    @State private var showingAlert = false
    
    var body: some View {
        Group {
            if gameState == .startGame {
                VStack(spacing: 20) {
                    Button("Tap Me") {
                        self.enabled.toggle()
                    }
                    .frame(width: 200, height: 200)
                    .background(enabled ? Color.blue : Color.red)
                    .animation(nil)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                    .animation(.interpolatingSpring(stiffness: 10, damping: 1))
                    
                    
                    Text("Pick your tables...")
                    
                    ForEach(0..<3, id: \.self) { row in
                        HStack {
                            ForEach(0..<4, id: \.self) { col in
                                Tile(value: row * 4 + col + 1, onTapped: self.tablePicked)
                            }
                        }
                    }
                    
                    Text("Number of Questions...")
                    Text("\(numberOfQuestions)")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Button("Add More") {
                        self.numberOfQuestions += 5
                    }
                    
                    Button("Play") {
                        self.startGame()
                    }
                    
                }
            
            } else if gameState == .playGame {
                Text("What is...")
                Text("\(questions.first?.0 ?? 0) x \(questions.first?.1 ?? 0)")
                Button("Next") {
                    
                    // TODO: - crashes when array is empty!
                    self.questions.removeFirst()
                }
            } else {
                Text("Game Over")
            }
        }
            // Photo by FWStudio from Pexels
            .background(Image("wood"))
            .font(.headline)
            .foregroundColor(.black)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("You need to pick at least one table!"), dismissButton: .default(Text("OK")) {
                    // do nothing
                    })
        }
    }

//    TODO
//    func gameView() -> AnyView {
//        switch gameState {
//        case .startGame:
//            return AnyView(StartGameView())
//        case .pickNumberQuestions:
//            return AnyView(PickNumberOfQuestionsView())
//        case .playGame:
//            return AnyView(GameView())
//        case .gameOver:
//            return AnyView(GameOverView())
//        }
//    }
    
    func startGame() {
        guard gameState == .startGame else {
            fatalError("That button should not be visible!")
        }
        
        guard !selectedTables.isEmpty else {
            showingAlert = true
            return
        }
        
        var possibleQuestions = [Int]()
        
        for _ in 0..<numberOfQuestions {
            questions.append((selectedTables.randomElement() ?? 7, [1,2,3,4,5,6,7,8,9,10,11,12].randomElement() ?? 7))
        }
        
        gameState = .playGame
    }
    
    func tablePicked(number: Int) -> Bool {
        if let index = selectedTables.firstIndex(of: number) {
            selectedTables.remove(at: index)
            return false
        } else {
            selectedTables.append(number)
            return true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
