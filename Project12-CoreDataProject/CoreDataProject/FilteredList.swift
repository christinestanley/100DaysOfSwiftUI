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
    
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        
        let sortDescriptor = NSSortDescriptor(key: filterKey, ascending: true)
        let predicate: NSPredicate? = (filterValue != "" ? NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue) : nil)
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [sortDescriptor], predicate: predicate)
        self.content = content
    }
    
}
