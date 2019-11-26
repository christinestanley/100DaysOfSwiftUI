//
//  UserView.swift
//  Friends
//
//  Created by Chris on 25/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct UserView: View {
    let user: User
    let users: [User]
    let friends : [User]
    
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
                    Text("Company: \(user.company)")
                    Text("Email: \(user.email)")
                    Text("Address: \(user.address)")
                }
                Section(header: Text("About")) {
                    Text(user.about)
                }
                Section(header: Text("Friends")) {
                    ForEach(friends) { friend in
                        NavigationLink(destination: UserView(user: friend, users: self.users)) {
                            HStack {
                                Image(systemName: "person.circle")
                                    .resizable()
                                    .frame(width: 32.0, height: 32.0)
                                    .foregroundColor(friend.isActive ? .green : .red)
                                Text(friend.name)
                                Text("(\(friend.friends.count) friends)")
                            }
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(user.name), displayMode: .inline)
    }

    init(user: User, users: [User]) {
        self.user = user
        self.users = users

        var matches = [User]()

        for friend in user.friends {
            if let match = users.first(where: { $0.id == friend.id }) {
                matches.append(match)
            } else {
                fatalError("Missing \(friend)")
            }
        }

        self.friends = matches
    }
}

struct UserView_Previews: PreviewProvider {
    static let user = User(id: "1", isActive: false, name: "Joe Bloggs", age: 20, company: "Company", email: "Email", address: "address", about: "about", registered: "", tags: [], friends: [])
    
    static var previews: some View {
        UserView(user: user, users: [user])
    }
}
