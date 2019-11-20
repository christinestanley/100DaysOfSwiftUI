//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Chris on 19/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Country.entity(), sortDescriptors: [], predicate: nil) var countries: FetchedResults<Country>
    
    @State var countryNameFilter = ""
    
    var body: some View {
        VStack {
            FilteredList(filterKey: "shortName", filterValue: countryNameFilter) { (country: Country) in
                Section(header: Text("\(country.wrappedShortName) \(country.wrappedFullName)")) {
                    ForEach(country.resortArray, id: \.self) { resort in
                        Text(resort.wrappedName)
                    }
                }
            }
            
            Button("Show A") {
                self.countryNameFilter = "A"
            }
            
            Button("Show F") {
                self.countryNameFilter = "F"
            }
            
            Button("Show All") {
                self.countryNameFilter = ""
            }
            
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
