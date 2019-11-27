//
//  CDUserView.swift
//  Friends
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI
import CoreData

struct CDUserView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CDUser.entity(), sortDescriptors: [], predicate: nil) var cdusers: FetchedResults<CDUser>
    
    let user: CDUser
    var friends: [CDUser] {
        var matches = [CDUser]()
        
        for friend in user.friendsArray {
            if let match = cdusers.first(where: { $0.id == friend.id }) {
                matches.append(match)
            } else {
                fatalError("Missing \(friend)")
            }
        }
        return matches
    }
    
    var body: some View {
        Group {
            VStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 72.0, height: 72.0, alignment: .center)
                    .foregroundColor(user.isActive ? .green : .red)
                Text("\(user.age) years old")
            }
            .padding()
            
            Form {
                Section(header: Text("Contact")) {
                    Text("Company: \(user.wrappedCompany)")
                    Text("Email: \(user.wrappedEmail)")
                    Text("Address: \(user.wrappedAddress)")
                }
                Section(header: Text("About")) {
                    Text(user.wrappedAbout)
                }
                Section(header: Text("Friends")) {
                    ForEach(friends, id: \.id) { (friend: CDUser) in
                        NavigationLink(destination: CDUserView(user: friend)) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 32.0, height: 32.0)
                                    .foregroundColor(friend.isActive ? .green : .red)
                                Text(friend.wrappedName)
                                Text("(\(friend.friendsArray.count) friends)")
                            }

                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(user.wrappedName), displayMode: .inline)
    }
}

