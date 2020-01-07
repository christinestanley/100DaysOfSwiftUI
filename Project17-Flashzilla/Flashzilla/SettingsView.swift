//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Chris on 07/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var retryWrongGuesses: Bool
    
    var body: some View {
        NavigationView {
            Toggle(isOn: $retryWrongGuesses) {
                Text("Retry wrong answers")
            }
            .font(.title)
            .frame(width: 450)
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(retryWrongGuesses: .constant(true))
    }
}
