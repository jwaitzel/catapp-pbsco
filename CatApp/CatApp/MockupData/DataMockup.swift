//
//  DataMockup.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//
import Foundation

extension Bundle {
    
    func decode<T : Codable>(_ file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file)")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(url)")
        }

        let decoder = JSONDecoder()
        var decodeData:T!
        do {
            decodeData = try decoder.decode(T.self, from: data)
            return decodeData
        } catch let error {
            fatalError("Error \(error) \(error.localizedDescription)")
        }
        return decodeData
    }
}

let catsMockupData:[Cat] = Bundle.main.decode("mockup_cats.json")
