//
//  ContentView.swift
//  Animations
//
//  Created by Chris on 25/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var stepAnimationAmount: CGFloat = 1
    @State private var rotateAnimationAmount = 0.0
    
    @State private var enabled = false
    
    let letters = Array("Hello SwiftUI")
    @State private var dragAmount = CGSize.zero

    @State private var isShowingRed = false
    
    var body: some View {
        TabView {
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
            .tabItem {
                Image(systemName: "1.circle.fill")
                Text("")
            }
            VStack {
                Button("Tap Me") {
                    self.enabled.toggle()
                }
                .frame(width: 200, height: 200)
                .background(enabled ? Color.blue : Color.red)
                .animation(.default)
                // .animation(nil)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                .animation(.interpolatingSpring(stiffness: 10, damping: 1))
            }
            .tabItem {
                Image(systemName: "2.circle.fill")
                Text("")
            }

            VStack {
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) { num in
                        Text(String(self.letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(self.enabled ? Color.blue : Color.red)
                            .offset(self.dragAmount)
                            .animation(Animation.default.delay(Double(num) / 20))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { self.dragAmount = $0.translation }
                        .onEnded { _ in
                            self.dragAmount = .zero
                            self.enabled.toggle()
                        }
                )
            }
            .tabItem {
                Image(systemName: "3.circle.fill")
                Text("")
            }

            VStack {
                Button("Tap Me") {
                    withAnimation {
                        self.isShowingRed.toggle()
                    }
                }
                
                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 200, height: 200)
                        // .transition(.scale)
                        // .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        .transition(.pivot)
                }
            }
            .tabItem {
                Image(systemName: "4.circle.fill")
                Text("")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
