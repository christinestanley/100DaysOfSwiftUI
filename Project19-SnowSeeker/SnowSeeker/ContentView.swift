//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Chris on 13/01/2020.
//  Copyright © 2020 Earlswood Marketiing Ltd. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var showFavouritesOnly = false
    
    // TODO: Refactor to remove hard coded resorts and code duplication on the filter sheet
    @State private var sortBy = 0
    private let sortOptions = ["default", "a to z", "country"]
    
    @State private var showingFilters = false
    
    private let countries =  ["Austria", "Canada", "France", "Italy", "United States"]
    
    @State private var showAustria = true
    @State private var showCanada = true
    @State private var showFrance = true
    @State private var showItaly = true
    @State private var showUS = true
    
    @State private var sizeFilter = 0
    private let size = ["All", "Small", "Medium", "Large"]
    @State private var priceFilter = 0
    private let price = ["All", "$", "$$", "$$$"]
    
    var sortedAndFilteredResorts: [Resort] {
        var sortedResorts = showFavouritesOnly ? resorts.filter { self.favorites.contains($0) } : resorts
        
        if !showAustria { sortedResorts = sortedResorts.filter { $0.country != "Austria" } }
        if !showCanada { sortedResorts = sortedResorts.filter { $0.country != "Canada" } }
        if !showFrance { sortedResorts = sortedResorts.filter { $0.country != "France" } }
        if !showItaly { sortedResorts = sortedResorts.filter { $0.country != "Italy" } }
        if !showUS { sortedResorts = sortedResorts.filter { $0.country != "United States" } }
        
        if sizeFilter > 0 {
            sortedResorts = sortedResorts.filter { $0.size == sizeFilter }
        }
        
        if priceFilter > 0 {
            sortedResorts = sortedResorts.filter { $0.price == priceFilter }
        }
        
        switch sortBy {
        case 1:
            sortedResorts = sortedResorts.sorted { $0.name < $1.name}
        case 2:
            sortedResorts = sortedResorts.sorted { $0.country < $1.country}
        default:
            break
        }
        
        return sortedResorts
    }
    
    var body: some View {
        NavigationView {
            List {
                
                Toggle(isOn: $showFavouritesOnly) {
                    Text("Favorites only")
                }
                
                HStack {
                    Text("Sort by")
                    
                    Picker(selection: $sortBy, label: Text("Sort")) {
                        ForEach(0..<sortOptions.count) { index in                            Text(self.sortOptions[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                ForEach(sortedAndFilteredResorts) { resort in
                    
                    NavigationLink(destination: ResortView(resort: resort)) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1))
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        .layoutPriority(1)
                        
                        if self.favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.red)
                        }
                    }
                    .accessibility(label: Text("\(resort.name) in \(resort.country). \(resort.runs) runs. \(self.favorites.contains(resort) ? "This is a favorite resort" : "") "))
                    
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingFilters = true
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
            })
            
            WelcomeView()
        }
        .environmentObject(favorites)
            //.phoneOnlyStackNavigationView()
        .sheet(isPresented: $showingFilters) {
            Text("Resort filters")
                .font(.title)
            
            Form {
                Section(header: Text("Country")) {
                    Toggle(isOn: self.$showAustria) {
                        Image("Austria")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("Austria")
                    }
                    .frame(height: 40)
                    
                    Toggle(isOn: self.$showCanada) {
                        Image("Canada")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("Canada")
                    }
                    .frame(height: 40)
                    
                    Toggle(isOn: self.$showFrance) {
                        Image("France")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("France")
                    }
                    .frame(height: 40)
                    
                    Toggle(isOn: self.$showItaly) {
                        Image("Italy")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("Italy")
                    }
                    .frame(height: 40)
                    
                    Toggle(isOn: self.$showUS) {
                        Image("United States")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Text("United States")
                    }
                    .frame(height: 40)
                }
                Section(header: Text("Ski Area")) {
                    
                    Picker(selection: self.$sizeFilter, label: Text("Size")) {
                        ForEach(0..<self.size.count) { index in                            Text(self.size[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Cost")) {
                    
                    
                    Picker(selection: self.$priceFilter, label: Text("Sort")) {
                        ForEach(0..<self.price.count) { index in                            Text(self.price[index]).tag(index)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// optional testing required!
extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}
