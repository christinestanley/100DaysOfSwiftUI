//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by Chris on 08/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import Foundation
import MapKit

// MKPointAnnotation isn’t a final class, which means other classes can inherit from it. So extending it with a required init is not possible.
// extension MKPointAnnotation: Codable {
//     public required init(from decoder: Decoder) throws {
//     }
//
//     public func encode(to encoder: Encoder) throws {
//     }
// }

class CodableMKPointAnnotation: MKPointAnnotation, Codable {
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }
    
    override init() {
        super.init()
    }
    
    public required init(from decoder: Decoder) throws {
        super.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}
