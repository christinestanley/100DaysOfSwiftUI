//
//  ContentView.swift
//  WeSplit
//
//  Created by Chris on 08/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    //@State private var numberOfPeople = 2
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    // Add Emoji to tip % header
    let tipEmojis = ["😏","🙂","😀","😋","😢"]
    
    var peopleCount: Double {
        return Double(Int(numberOfPeople) ?? 1)
    }
    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    var totalPerPerson: Double {
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    // Day 18 Challenge 3: Change the “Number of people” picker to be a text field, making sure to use the correct keyboard type.
                    //Picker("Number of people", selection: $numberOfPeople) {
                    //    ForEach(2..<100) {
                    //        Text("\($0) people")
                    //    }
                    //}
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header: Text("How much tip do \(tipEmojis[tipPercentage]) want to leave? ")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count ) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                // Day 18 Challenge 2: Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
                Section(header: Text("Total including tip")) {
                    Text("£\(grandTotal, specifier: "%.2f")")
                }
                // Day 18 Challenge 1: Add a header to the third section, saying “Amount per person”
                Section(header: Text("Amount per person")) {
                    Text("£\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
