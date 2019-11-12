//
//  ContentView.swift
//  Habits
//
//  Created by Chris on 11/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var activities = Activities()
    
    @State private var showingNewHabit = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button("Add new habit...") {
                    self.showingNewHabit = true
                }
                .padding(.leading)
                    
                List {
                    ForEach(activities.items.indices, id: \.self) { idx in
                        NavigationLink(destination: ActivityDetail(activity: self.$activities.items[idx])) {
                            HStack {
                                Text(self.activities.items[idx].name)
                                ForEach(0..<self.activities.items[idx].counter, id: \.self) { _ in
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 10, height: 10)
                                }
                            }
                       }
                    }
                    .onDelete(perform: removeItems)
                }
            
                
            }
            .navigationBarTitle("Habits")
            .padding()
        }
        .sheet(isPresented: $showingNewHabit) {
            AddActivity(activities: self.activities)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
