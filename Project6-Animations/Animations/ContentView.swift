//
//  ContentView.swift
//  Animations
//
//  Created by Chris on 25/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var stepAnimationAmount: CGFloat = 1
    @State private var rotateAnimationAmount = 0.0
    
    var body: some View {
        VStack {
            
            // Implicit animation
            // Use padding on the Text rather than the button so the whole circle it tappable
            Button(action: {
                //self.animationAmount += 1
            }) {
                Text("Tap Me")
                    .padding(50)
            }
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.red)
                    .scaleEffect(animationAmount)
                    .opacity(Double(2 - animationAmount))
                    .animation(
                        Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false)
                )
            )
                //.blur(radius: (animationAmount - 1) * 3)
                .onAppear {
                    self.animationAmount = 2
            }
            
            Divider()
            
            // Animating bindings
            Stepper("Scale amount: \(stepAnimationAmount, specifier: "%g" )", value: $stepAnimationAmount.animation(), in: 1...10)
            
            Spacer()
            
            Button("Tap Me") {
                self.stepAnimationAmount += 1
            }
            .padding(40)
            .background(Color.orange)
            .foregroundColor(.white)
            .clipShape(Circle())
            .scaleEffect(stepAnimationAmount)
            
            Spacer()
            
            Divider()
            
            // Explicit animations
            Button("Tap Me") {
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.rotateAnimationAmount += 360
                }
            }
            .padding(50)
            .background(Color.green)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(rotateAnimationAmount), axis: (x: 0, y: 1, z: 0))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
