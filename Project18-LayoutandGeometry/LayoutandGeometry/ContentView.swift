//
//  ContentView.swift
//  LayoutandGeometry
//
//  Created by Chris on 09/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        // TODO: tidy up the maths!
        TabView {
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("\(index)")
                                .font(.title)
                                .bold()
                                .frame(width: 250 - abs(geo.frame(in: .global).minY - fullView.size.height / 2) * 0.75 , height: 80 - abs(geo.frame(in: .global).minY - fullView.size.height / 2) * 0.25, alignment: .center)
                                .background(self.colors[index % 7])
                                .clipShape(Capsule())
                                .offset(x: 140 - abs(geo.frame(in: .global).minY - fullView.size.height / 2) / 3)
                                .opacity(1 - Double(abs(geo.frame(in: .global).midY - fullView.size.height / 2) / (fullView.size.height / 2) ) )
                                .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 0, z: 1))
                            
                        }
                        .frame(height: 60)
                    }
                }
            }
            .tabItem {
                Image(systemName: "1.circle")
            }
            
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(width: fullView.size.width)
                                .background(self.colors[index % 7])
                                .rotation3DEffect(.degrees(Double(geo.frame(in: .global).minY - fullView.size.height / 2) / 5), axis: (x: 0, y: 1, z: 0))
                        }
                        .frame(height: 40)
                    }
                }
            }
            .tabItem {
                Image(systemName: "2.circle")
            }
            
            GeometryReader { fullView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<50) { index in
                            GeometryReader { geo in
                                Rectangle()
                                    .fill(self.colors[index % 7])
                                    .frame(height: 150)
                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                            }
                            .frame(width: 150)
                        }
                    }
                    .padding(.horizontal, ((fullView.size.width - 150) / 2))
                }
            }
            .edgesIgnoringSafeArea(.all)
            .tabItem {
                Image(systemName: "3.circle")
            }
            
            HStack {
                VStack {
                    Text("@twostraws")
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 64, height: 64)
                    Text("@twostraws")
                }
                
                VStack {
                    Text("Full name:")
                    Text("PAUL HUDSON")
                        .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                        .font(.largeTitle)
                }
            }
            .tabItem {
                Image(systemName: "4.circle")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
