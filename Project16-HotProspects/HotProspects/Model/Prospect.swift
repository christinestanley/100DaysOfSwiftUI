//
//  Prospect.swift
//  HotProspects
//
//  Created by Chris on 15/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    let id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var dateMet = Date()
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    static let saveKey = "SavedData"
    
    init() {
        
        // Day 85 challenge 2: Use JSON and the documents directory for saving and loading our user data. See Extension on FileManager
        self.people = FileManager.default.readDocument(from: Self.saveKey) ?? []
        
        //        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
        //            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
        //                self.people = decoded
        //                return
        //            }
        //        }
        //
        //        self.people = []
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        // Day 85 challenge 2: Use JSON and the documents directory for saving and loading our user data.
        guard FileManager.default.writeDocument(people, to: Self.saveKey) else {
            print("Unable to save data.")
            return
        }
        
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//        }
    }
}
