//
//  FileManager-Codable.swift
//  HotProspects
//
//  Created by Chris on 17/12/2019.
//  Copyright © 2019 Earlswood Marketiing Ltd. All rights reserved.
//

import Foundation

extension FileManager {
    var documentDirectoryPath: URL {
        guard let path = urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not find File Manager Document Directory")
        }
        
        return path
    }
    
    func readDocument<T: Codable>(from file: String) -> T? {
        let path = documentDirectoryPath.appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: path) else {
            print("Could not read contents of \(path)")
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            print("Could not decode contents of \(path)")
            return nil
        }
                
        return decodedData
    }
    
    func writeDocument<T: Codable>(_ data: T, to file: String) -> Bool {
        let path = documentDirectoryPath.appendingPathComponent(file).path
        let encoder = JSONEncoder()
        
        guard let encodedData = try? encoder.encode(data) else {
            print("Could not encode data")
            return false
        }
        
        return FileManager.default.createFile(atPath: path, contents: encodedData, attributes: nil)
    }
}
