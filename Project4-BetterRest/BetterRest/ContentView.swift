//
//  ContentView.swift
//  BetterRest
//
//  Created by Chris on 20/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            Text("BetterRest")
                .font(.largeTitle)
                .fontWeight(.black)
            Text("Go to bed by \(formattedBedtime)")
                .font(.title)
                .foregroundColor(afterBedtime ? .red : .green)
            Form {
                Section(header: Text("When do you want to wake up?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Daily coffee intake")) {
                    // Challenge 2: complete but Stepper seems a better choice here
                    // Picker("Select coffee amount", selection: $coffeeAmount) {
                    //     ForEach( 0...20, id: \.self) {
                    //         Text("\($0) Cup\($0 == 1 ? "" : "s")")
                    //     }
                    // }
                    // .labelsHidden()
                    Stepper(value: $coffeeAmount, in: 0...20) {
                        if coffeeAmount == 1 {
                            Text("1 cup")
                        } else {
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
            }
            
            
            // Challenge 3: navigation bar item example removed
            // .navigationBarItems(trailing:
            //     Button(action: calculateBedtime) {
            //         Text("Calculate")
            //     }
            // )
            //     .alert(isPresented: $showingAlert) {
            //         Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            // }
        }
    }
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    private var bedtime: Date {
        let model = SleepCalculator()
        
        do {
            let prediction = try model.prediction(wake: timeInSeconds(wakeUp), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            return wakeUp - prediction.actualSleep
            
        } catch {
            return Date() // If in doubt go to bed!
        }
    }
    
    private var formattedBedtime: String {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
        return formatter.string(from: bedtime)
    }
    
    private var afterBedtime: Bool {
        if timeInSeconds(wakeUp) < timeInSeconds(bedtime) {
            return timeInSeconds(bedtime) < timeInSeconds(Date())
        } else {
            return (timeInSeconds(Date()) > timeInSeconds(bedtime)) && (timeInSeconds(Date()) < timeInSeconds(wakeUp))
        }
    }
    
    private func timeInSeconds(_ date: Date) -> Double {
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        return Double(hour + minute)
    }
    
// Challenge 3 alert removed
//    func calculateBedtime() {
//        let model = SleepCalculator()
//
//        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//        let hour = (components.hour ?? 0) * 60 * 60
//        let minute = (components.minute ?? 0) * 60
//
//        do {
//            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            let sleepTime = wakeUp - prediction.actualSleep
//            let formatter = DateFormatter()
//            formatter.timeStyle = .short
//            alertMessage = formatter.string(from: sleepTime)
//            alertTitle = "Your ideal bedtime is..."
//        } catch {
//            alertTitle = "Error"
//            alertMessage = "Sorry, there was a problem calculating your bedtime."
//        }
//
//        showingAlert = true
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
