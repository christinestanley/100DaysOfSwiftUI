//
//  CDFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    
    public var wrappedId: String {
        id ?? "007"
    }
    
    public var wrappedName: String {
        name ?? "James Bond"
    }

}
