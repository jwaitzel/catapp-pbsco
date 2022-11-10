//
//  Cat.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import SwiftUI

struct Cat: Identifiable, Codable {
    var id: String
    var tags: [String]
    var owner: String?
    var createdAt: String
    var updatedAt: String
        
    //MARK: Needed to rename _id to id
    private enum CodingKeys : String, CodingKey {
        case id = "_id", tags, owner, createdAt, updatedAt
    }

    func imageURL() -> URL {
        guard let  url = URL(string: "https://cataas.com/cat/\(id)") else {
            fatalError("Missing url")
        }
        return url
    }
}
