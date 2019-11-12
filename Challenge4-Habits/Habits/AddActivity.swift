//
//  AddActivity.swift
//  Habits
//
//  Created by Chris on 11/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct AddActivity: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activities: Activities
    
    @State private var name = ""
    @State private var description = ""
    
    private var disableSave: Bool {
        name == ""
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(
                trailing: Button("Save") {
                    self.validateHabit()
                    self.presentationMode.wrappedValue.dismiss()
                }
            .disabled(disableSave)
            )
        }
    }
            
    func validateHabit() {
        guard name != "" else {
            return
        }
        
        let activity = Activity(name: name, description: description != "" ? description : "Your \(name) habit.")
        activities.items.append(activity)
    }
}

struct AddActivity_Previews: PreviewProvider {
    
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
