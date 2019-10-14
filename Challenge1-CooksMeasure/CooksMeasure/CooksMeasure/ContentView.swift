//
//  ContentView.swift
//  CooksMeasure
//
//  Created by Chris on 12/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnit = 0
    @State private var outputUnit = 2
    
    let units = ["grams", "kilos", "ozs"]
    
    private var massInKilos: Measurement<UnitMass> {
        let value = Double(inputValue) ?? 0
        switch units[inputUnit] {
        case "grams":
            let grams = Measurement(value: value, unit: UnitMass.grams)
            return grams.converted(to: UnitMass.kilograms)
        case "kilos":
            return Measurement(value: value, unit: UnitMass.kilograms)
        case "ozs":
            let ozs = Measurement(value: value, unit: UnitMass.ounces)
            return ozs.converted(to: UnitMass.kilograms)
        default:
            return Measurement(value: 0, unit: UnitMass.kilograms)
        }
    }
    
    private var formattedMass: String {
        switch units[outputUnit] {
        case "grams":
            let grams = massInKilos.converted(to: UnitMass.grams)
            return "\(grams.value) \(grams.unit.symbol)"
        case "kilos":
            return "\(massInKilos.value) \(massInKilos.unit.symbol)"
        case "ozs":
            let ozs = massInKilos.converted(to: UnitMass.ounces)
            return "\(ozs.value) \(ozs.unit.symbol)"
        default:
            return "0.0"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section() {
                    TextField("Weight", text:$inputValue)
                        .keyboardType(.numberPad)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted to")) {
                    Text("\(formattedMass)")
                    
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(0..<units.count) {
                            Text("\(self.units[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                }
            }
            .navigationBarTitle("Cooks' Measure")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
