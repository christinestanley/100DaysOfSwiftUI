//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Chris on 10/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

enum Direction: CaseIterable, Hashable, Identifiable {
    case up, down, left, right
    
    var name: String {
        return "\(self)".map {
            $0.isUppercase ? " \($0)" : "\($0)" }.joined().capitalized
    }
    var id: Direction {self}
}

struct Arrow: Shape {
    var direction: Direction = .up
    
    func path(in rect: CGRect) -> Path {
        
        var path = Path()
        
        var rotatedRect = rect
        if direction == .left || direction == .right {
            rotatedRect = CGRect(x: rect.minX, y: rect.minY, width: rect.height, height: rect.width)
        }
        
        path.move(to: CGPoint(x: rotatedRect.midX / 2, y: rotatedRect.maxY))
        path.addLine(to: CGPoint(x: rotatedRect.midX + (rotatedRect.midX / 2), y: rotatedRect.maxY))
        path.addLine(to: CGPoint(x: rotatedRect.midX + (rotatedRect.midX / 2), y: rotatedRect.midY))
        path.addLine(to: CGPoint(x: rotatedRect.maxX, y: rotatedRect.midY))
        path.addLine(to: CGPoint(x: rotatedRect.midX, y: rotatedRect.minY))
        path.addLine(to: CGPoint(x: rotatedRect.minX, y: rotatedRect.midY))
        path.addLine(to: CGPoint(x: rotatedRect.midX - (rotatedRect.midX / 2), y: rotatedRect.midY))
        path.addLine(to: CGPoint(x: rotatedRect.midX / 2, y: rotatedRect.maxY))
        path.addLine(to: CGPoint(x: rotatedRect.midX + (rotatedRect.midX / 2), y: rotatedRect.maxY))
        
        switch direction {
        case .up:
            break
        case .right:
            let rotation = CGAffineTransform(rotationAngle: CGFloat.pi / 2 )
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width, y: 0))
            path = path.applying(position)
        case .left:
            let rotation = CGAffineTransform(rotationAngle: -CGFloat.pi / 2 )
            let position = rotation.concatenating(CGAffineTransform(translationX: 0, y: rect.height))
            path = path.applying(position)
        case .down:
            let rotation = CGAffineTransform(rotationAngle: CGFloat.pi )
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width, y: rect.height))
            path = path.applying(position)
        }
        
        return path
    }
}

struct ColorCyclingRect: View {
    var amount = 0.0
    var steps = 40

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var direction: Direction = .up
    @State private var lineWidth: CGFloat = 10
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            
            ZStack {
                ColorCyclingRect(amount: self.colorCycle)
                    .frame(width: 350, height: 500)
                
                withAnimation() {
                    Arrow(direction: direction)
                        .stroke(Color.green, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .frame(width: 200, height: 300)
                }
                
            }
            .padding(.bottom, 50)
            
            Section(header: Text("Which Way?"))
            {
                Picker("Which Way?", selection: $direction) {
                    ForEach(Direction.allCases) { d in
                        Text(d.name).tag(d)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom)
                
                Text("Line width: \(Int(lineWidth))")
                Slider(value: $lineWidth, in: 1...70, step: 1)
                
                Text("Color cycle")
                Slider(value: $colorCycle)
            }
            .padding(.horizontal)
            .padding(.horizontal)
            .foregroundColor(.red)
            .font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
