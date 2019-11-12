//
//  ActivityDetail.swift
//  Habits
//
//  Created by Chris on 11/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ActivityDetail: View {
    @Binding var activity: Activity
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("\(activity.description)")
            Text("You've done \(activity.counter) so far.")
                .font(.headline)
            Text("How did you do today?")
                .font(.headline)
                .fontWeight(.bold)
            Button(action: { self.activity.counter += 1 }) {
                
                Text("+1")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .background(Color.green)
                    .accentColor(.primary)
                    .cornerRadius(35)
            }
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(activity.name)
    }
    
}

struct ActivityDetail_Previews: PreviewProvider {
    @State static var activity = Activity(name: "French", description: "15 minutes of French with Duo")

    static var previews: some View {
        ActivityDetail(activity: $activity)
    }
}
