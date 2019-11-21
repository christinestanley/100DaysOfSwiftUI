//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Chris on 20/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                self.content(item)
            }
        }
    }
    
    init(filterKey: String, filterValue: String, filterType: FilterType, sortBy: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        
        //let sortDescriptor = NSSortDescriptor(key: filterKey, ascending: true)
        var predicate: NSPredicate?
        
        switch filterType {
        case .equals:
            predicate = (filterValue != "" ? NSPredicate(format: "%K == %@", filterKey, filterValue) : nil)
        case .lessThan:
            predicate = (filterValue != "" ? NSPredicate(format: "%K < %@", filterKey, filterValue) : nil)
        case .beginsWith:
            predicate = (filterValue != "" ? NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue) : nil)
        case .not:
            predicate = (filterValue != "" ? NSPredicate(format: "NOT %K == %@", filterKey, filterValue) : nil)
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortBy, predicate: predicate)
        self.content = content
    }
    
}
