//
//  CatAPIManager.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import SwiftUI

class CatAPIManager {
    
    static let shared: CatAPIManager = .init()
    
    //MARK: Query properties
    let fetchLimit: Int = 10
    
    func fetchCats(tags: String = "", pageSkip:Int = 0) async -> ([Cat], String?) {
        do {
            guard let url = URL(string: "https://cataas.com/api/cats?tags=\(tags)&skip=\(pageSkip)&limit=\(fetchLimit)") else {
                throw "Missing or incorrect url"
            }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//            print("Req \(urlRequest)")
            //Check for 200 success status code
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw "Server response code \((response as? HTTPURLResponse)?.statusCode ?? 520)" //Unknow error
            }
            
            let decoder = JSONDecoder()
            let cats = try decoder.decode([Cat].self, from: data)
            //MARK: Fix for limit API wrong result, seems like the fetchLimit paramter is not being used
            let maxLimit = min(fetchLimit, cats.count)-1
            return (Array(cats[...maxLimit]), nil)
        }  catch {
            let errMsg = "Error fetching cats - \(error.localizedDescription)"
            print(errMsg)
            return ([], errMsg)
        }
    }
    
}

extension String: Error {}
extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
