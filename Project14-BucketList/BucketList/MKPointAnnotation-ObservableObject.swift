//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Chris on 06/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown value"
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }
        
        set {
            subtitle = newValue
        }
    }
}
