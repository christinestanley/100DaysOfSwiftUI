//
//  ContentView.swift
//  Friends
//
//  Created by Chris on 25/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users, id: \.id) { user in
                NavigationLink(destination: UserView(user: user, users: self.users)) {
                    HStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 40.0, height: 40.0)
                            .foregroundColor(user.isActive ? .green : .red)
                        Text(user.name)
                        Text("(\(user.friends.count) friends)")
                    }.padding(5)
                }
            }
        .navigationBarTitle("Friends")
        .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
