//
//  Resort+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Chris on 21/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//
//

import Foundation
import CoreData


extension Resort {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Resort> {
        return NSFetchRequest<Resort>(entityName: "Resort")
    }

    @NSManaged public var name: String?
    @NSManaged public var location: Country?
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

}
