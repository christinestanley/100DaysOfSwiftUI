//
//  CDUser+CoreDataProperties.swift
//  Friends
//
//  Created by Chris on 26/11/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var friends: NSSet?
    
    public var wrappedId: String {
        id ?? "007"
    }
    
    public var wrappedName: String {
        name ?? "James Bond"
    }
    
    public var wrappedAbout: String {
        about ?? ""
    }
    
    public var wrappedAddress: String {
        address ?? ""
    }
    
    public var wrappedCompany: String {
        company ?? ""
    }
    
    public var wrappedEmail: String {
        email ?? ""
    }
    
    public var friendsArray: [CDFriend] {
        let set = friends as? Set<CDFriend> ?? []
        
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CDUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CDFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CDFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}
