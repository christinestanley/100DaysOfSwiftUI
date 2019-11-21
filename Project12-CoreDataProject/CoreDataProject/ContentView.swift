//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Chris on 19/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import CoreData
import SwiftUI

enum FilterType: String, CaseIterable {
    case equals = "=="
    case lessThan = "<"
    case beginsWith = "BEGINSWITH"
    case not = "NOT"
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: [], predicate: nil) var countries: FetchedResults<Country>
    
    @State private var countryNameFilter = ""
    @State private var filterType = FilterType.equals
    
    var body: some View {
        NavigationView {
            VStack {
                FilteredList(filterKey: "fullName", filterValue: countryNameFilter, filterType: filterType, sortBy: [NSSortDescriptor(key: "fullName", ascending: true)]) { (country: Country) in
                    Section(header: Text("\(country.wrappedFullName) \(country.wrappedShortName)")) {
                        ForEach(country.resortArray, id: \.self) { resort in
                            Text(resort.wrappedName)
                        }
                    }
                }
                
                Section(header: Text("Filter country by")) {
                    Picker("Predicate type", selection: $filterType) {
                        ForEach(FilterType.allCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                    HStack {
                        Text(filterType.rawValue)
                        TextField("Add filter string...", text: $countryNameFilter)
                    }
                    .padding([.leading, .trailing])
                }
                .padding([.leading, .trailing])
                
//                Button("Show A") {
//                    self.countryNameFilter = "A"
//                }
//
//                Button("Show All") {
//                    self.countryNameFilter = ""
//                }
                
                Button("Add") {
                    let resort1 = Resort(context: self.moc)
                    resort1.name = "Tignes"
                    resort1.location = Country(context: self.moc)
                    resort1.location?.shortName = "FR"
                    resort1.location?.fullName = "France"
                    
                    let resort2 = Resort(context: self.moc)
                    resort2.name = "Val Thorens"
                    resort2.location = Country(context: self.moc)
                    resort2.location?.shortName = "FR"
                    resort2.location?.fullName = "France"
                    
                    let resort3 = Resort(context: self.moc)
                    resort3.name = "St Anton"
                    resort3.location = Country(context: self.moc)
                    resort3.location?.shortName = "AT"
                    resort3.location?.fullName = "Austria"
                    
                    let resort4 = Resort(context: self.moc)
                    resort4.name = "Seefeld"
                    resort4.location = Country(context: self.moc)
                    resort4.location?.shortName = "AT"
                    resort4.location?.fullName = "Austria"
                    
                    let resort5 = Resort(context: self.moc)
                    resort5.name = "Wengen"
                    resort5.location = Country(context: self.moc)
                    resort5.location?.shortName = "CH"
                    resort5.location?.fullName = "Switzerland"
                    
                    let resort6 = Resort(context: self.moc)
                    resort6.name = "Soldeu"
                    resort6.location = Country(context: self.moc)
                    resort6.location?.shortName = "AD"
                    resort6.location?.fullName = "Andorra"
                    
                    let resort7 = Resort(context: self.moc)
                    resort7.name = "Åre"
                    resort7.location = Country(context: self.moc)
                    resort7.location?.shortName = "SE"
                    resort7.location?.fullName = "Sweden"
                }
                
                Button("Save") {
                    if self.moc.hasChanges {
                        do {
                            try self.moc.save()
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            .navigationBarTitle("Ski Resorts")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
