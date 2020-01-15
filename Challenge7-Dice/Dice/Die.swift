//
//  Die.swift
//  Dice
//
//  Created by Chris on 12/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

class Die: ObservableObject {
    var value: Int {
        willSet {
            objectWillChange.send()
        }
    }
    private let sides: Int
    
    func roll() {
        self.value = Int.random(in: 1...sides)
    }
    
    init (sides: Int) {
        self.sides = sides
        self.value = Int.random(in: 1...sides)
    }
}
