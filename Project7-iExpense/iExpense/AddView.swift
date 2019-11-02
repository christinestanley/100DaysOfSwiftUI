//
//  AddView.swift
//  iExpense
//
//  Created by Chris on 30/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    @State private var showAmountAlert = false
    @State private var itemValidated = false
    
    static let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(
                trailing: Button("Save") {
                    self.validateItem()
                    if self.itemValidated {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        self.showAmountAlert = true
                    }
                }
                .alert(isPresented: $showAmountAlert) {
                    Alert(title: Text("Amount must be a whole number"), message: Text("Please try again"), dismissButton: .default(Text("Ok")))
                }
            )
        }
    }
    
    func validateItem() {
        if let actualAmount = Int(amount) {
            let item = ExpenseItem(name: name, type: type, amount: actualAmount)
            expenses.items.append(item)
            itemValidated = true
        }
    }
}
    
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
