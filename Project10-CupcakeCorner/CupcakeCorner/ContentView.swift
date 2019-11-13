//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Chris on 11/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = OrderWrapper()
    
    @State private var cakeType = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.order.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.order.quantity, in: 3...20) {
                        Text("number of cakes: \(order.order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.order.specialRequestEnabled {
                        Toggle(isOn: $order.order.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                Section {
                    NavigationLink( destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
                
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
