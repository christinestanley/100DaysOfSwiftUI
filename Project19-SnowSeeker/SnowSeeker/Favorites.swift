//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Chris on 15/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    // userDefaults key
    private let saveKey = "Favorites"
    private let defaults = UserDefaults.standard
    
    init() {
        if let savedArray = defaults.object(forKey: saveKey) as? [String] {
            self.resorts = Set(savedArray)
        } else {
            self.resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        return resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        defaults.set(Array(resorts), forKey: saveKey)
    }
}
