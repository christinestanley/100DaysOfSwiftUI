//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Chris on 16/10/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//
//  Examples of Views and View Modifiers from Day 23 100DaysOfSwiftUI

import SwiftUI

// MARK: - View Composition - small reusable custom views
struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.title)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

// MARK: - Custom Modifiers
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func myTitleStyle() -> some View {
        self.modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }
}

//MARK: - Custom Containers
struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content
    
    var body: some View {
        VStack {
            ForEach(0..<rows) { row in
                HStack {
                    ForEach(0..<self.columns) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
    
    // @ViewBuilder
    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}

// MARK: - ContentView
struct ContentView: View {
    @State private var useRedText = false
    
    // stored properties
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    // computed properties
    var motto3: some View { Text("Draco non somnum") }
    var motto4: Text { motto1 }
        
    var body: some View {
        TabView {
            // MARK: - Video 2 "What is behind a View?"
            // MARK: - Video 3 "Modifier order matters."
            VStack(spacing: 20) {
                Text("There is Nothing behind the View")
                
                Text("Hello, World!")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .edgesIgnoringSafeArea(.all)
                
                Text("Order of modifiers matters")
                
                Button("Hello, World!") {
                    // do nothing
                }
                .background(Color.red)
                .frame(width: 200, height: 50)
                
                Button("Hello, World!") {
                    // do nothing
                }
                .frame(width: 200, height: 50)
                .background(Color.red)
                
                // each modifier creates a new view
                Text("Hello, World!")
                    .padding()
                    .background(Color.red)
                    .padding()
                    .background(Color.yellow)
                    .padding()
                    .background(Color.green)
                    .padding()
                    .background(Color.blue)
            }
            .tabItem {
                Image(systemName: "2.square.fill")
                Text("")
            }
            
            
            // MARK: - Video 5 "Conditional Modifiers"
            // MARK: - Video 6 "Environment Modifiers"
            VStack(spacing: 20) {
                Text("Conditional Modifiers")
                
                Button("Hello, World!") {
                    self.useRedText.toggle()
                }
                .frame(width: 200, height: 200)
                .background(Color.red)
                .foregroundColor(useRedText ? .yellow : .blue)
                
                Text("Environment Modifiers")
                // font() is an environment modifier. The regular font() of a Text View overrides it
                // blur() is a regular modifier. The font() of a Text View overrides it
                
                VStack {
                    Text("Gryffindor")
                    Text("Hufflepuff")
                    Text("Ravenclaw")
                        // overrides environment modifier
                        .font(.body)
                    Text("Slytherin")
                        // adds to environment modifier
                        .blur(radius: 0.0)
                }
                    // .font is an environment modifier
                    .font(.largeTitle)
                    // .blur is a regular modifier
                    .blur(radius: 2.0)
                Spacer()
            }
            .tabItem {
                Image(systemName: "5.square.fill")
                Text("")
            }
            
            // MARK: - Video 7 "Views as Properties"
            VStack(spacing: 20) {
                Text("Views as Properties")
                motto1
                motto2
                motto3
                    .foregroundColor(.red)
                Spacer()
            }
            .tabItem {
                Image(systemName: "7.square.fill")
                Text("")
            }
            // MARK: - Video 8 "View Composition"
            // MARK: - Video 9 "Custom Modifiers"
            VStack(spacing: 20){
                Text("View Composition")
                    
                Text("Using custom View struct")
                
                CapsuleText(text: "First")
                    .foregroundColor(.white)
                
                CapsuleText(text: "Second")
                    .foregroundColor(.black)
                
                Text("Custom Modifiers")
                
                Text("Hello, World!")
                    .modifier(Title())
                
                Color.blue
                    .frame(width: 300, height: 100)
                    .watermarked(with: "Hacking with Swift")

                Spacer()
            }
            .tabItem {
                Image(systemName: "8.square.fill")
                Text("")
            }
            
            //MARK: - Video 10: "Custom Containers"
            VStack(spacing: 20){
                Text("Custom Containers")
                
                GridStack(rows: 4, columns: 4) { row, col in
                        Image(systemName: "\(row * 4 + col).circle")
                        Text("R\(row),C\(col)")
                }
                
                Spacer()
            }
            .tabItem {
                Image(systemName: "10.square.fill")
                Text("")
            }
            
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
