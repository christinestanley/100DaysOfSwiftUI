//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Chris on 20/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var resort: NSSet?
    
    public var wrappedFullName: String {
        fullName ?? "Unknown"
    }

    public var wrappedShortName: String {
        shortName ?? "Unknown"
    }

    public var resortArray: [Resort] {
        let set = resort as? Set<Resort> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for resort
extension Country {

    @objc(addResortObject:)
    @NSManaged public func addToResort(_ value: Resort)

    @objc(removeResortObject:)
    @NSManaged public func removeFromResort(_ value: Resort)

    @objc(addResort:)
    @NSManaged public func addToResort(_ values: NSSet)

    @objc(removeResort:)
    @NSManaged public func removeFromResort(_ values: NSSet)

}
