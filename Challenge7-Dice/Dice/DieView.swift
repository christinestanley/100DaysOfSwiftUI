//
//  DieView.swift
//  Dice
//
//  Created by Chris on 12/01/2020.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct DieView: View {
    @State private var rotateAnimationAmount = Double(Int.random(in: -8...8))
    @State private var change = false
    @ObservedObject var die: Die
    
    var body: some View {
        Text(String(die.value))
            .foregroundColor(.black)
            .font(.largeTitle)
            .fontWeight(.bold)
            .opacity(change ? 0.0 : 1.0)
            .transition(.opacity)
            .frame(width: 100, height: 100)
            .background(Color.yellow)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 1).foregroundColor(.black))
            .shadow(color: .black, radius: 4, x: 0, y: 0)
            .rotation3DEffect(.degrees(rotateAnimationAmount), axis: (x: 0, y: 0, z: 1))
            .onReceive(die.objectWillChange) { _ in
                self.change = true
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.rotateAnimationAmount += self.randomSigned(330)
                }
                withAnimation(Animation.easeIn(duration: 1).delay(0.3)) {
                    self.change = false
                }
        }
    }
    
    func randomSigned(_ value: Double) -> Double {
        return Double(Int.random(in: 1...2) * 2 - 3) * value
    }
}
