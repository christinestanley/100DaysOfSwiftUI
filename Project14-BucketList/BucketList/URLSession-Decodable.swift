//
//  URLSession-Decodable.swift
//  BucketList
//
//  Created by Chris on 06/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import Foundation

extension URLSession {
    // TODO: - Write a generic version 
//    func decode<T: Codable>(_ urlString: String) throws -> T {
//        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(placemark.coordinate.latitude)%7C\(placemark.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
//
//        guard let url = URL(string: urlString) else {
//            print("Bad URL: \(urlString)")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                // we got some data back!
//                let decoder = JSONDecoder()
//
//                if let items = try? decoder.decode(Result.self, from: data) {
//                    // success – convert the array values to our pages array
//                    self.pages = Array(items.query.pages.values)
//                    self.loadingState = .loaded
//                    return
//                }
//            }
//
//            // if we're still here it means the request failed somehow
//            self.loadingState = .failed
//        }.resume()
//    }
}
