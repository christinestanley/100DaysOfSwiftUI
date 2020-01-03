//
//  Card.swift
//  Flashzilla
//
//  Created by Chris on 31/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String
    
    static var example: Card {
        return Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
