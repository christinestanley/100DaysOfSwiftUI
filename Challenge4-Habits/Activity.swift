//
//  Activity.swift
//  Habits
//
//  Created by Chris on 11/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import Foundation

struct Activity: Identifiable, Codable {
    var name: String
    var description: String
    var counter: Int = 0
    
    let id = UUID()
}
