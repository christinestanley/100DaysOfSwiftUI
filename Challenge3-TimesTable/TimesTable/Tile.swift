//
//  Number.swift
//  TimesTable
//
//  Created by Chris on 28/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct Tile: View {
    @State private var isActive = false
    @State private var angle = Angle(degrees: Double(Int.random(in: -8...8)))
    
    var value: Int
    var onTapped: ((Int) -> Bool)?
    
    var body: some View {
        
        Text(String(value))
            .font(.title)
            .fontWeight(.bold)
            .frame(width: 50, height: 50)
            .background(Color.yellow)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.black))
            .opacity(isActive ? 1.0 : 0.5)
            .rotationEffect(angle)
            .shadow(color: .black, radius: 4, x: 3, y: 3)
//            .rotationEffect(isActive ? Angle(degrees: 3.0) : .zero)
//            .animation(
//                Animation.default
//                .repeatForever(autoreverses: true)
//            )
            .gesture(
                TapGesture()
                    .onEnded {
                        self.isActive = self.onTapped?(self.value) ?? false
                    }
            )
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
        Tile(value: 8)
    }
}
