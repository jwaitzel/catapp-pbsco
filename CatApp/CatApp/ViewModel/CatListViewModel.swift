//
//  CatListViewModel.swift
//  CatApp
//
//  Created by javi www on 11/9/22.
//

import Foundation

class CatListViewModel: ObservableObject {
    
    @Published var cats: [Cat] = []
    @Published var errorMessage: String? = nil

    var pageSkip: Int = Int.random(in: 0...500) //Starts at some random value so its different each time
    @Published var initialFetch = false
    @Published var fetchingMore = false
    
    var tags:String = ""
    
    func fetch() {
//        let mock = false
//        if mock {
//            cats = catsMockupData //[catsMockupData.first!]
//            return
//        }
        Task.init {
            let (fetchedCats, errorMsg) = await CatAPIManager.shared.fetchCats(tags: tags, pageSkip: pageSkip)
            if !fetchedCats.isEmpty {
                DispatchQueue.main.async {
                    self.cats = fetchedCats
                    self.pageSkip += fetchedCats.count
                }
            } else {
                DispatchQueue.main.async {   
                    self.errorMessage = errorMsg
                }
            }
        }
    }
    
    func fetchMore() {
        if fetchingMore {
            print("Already fetching")
            return
        }
        fetchingMore = true
        self.errorMessage = nil
        
        Task.init {
            let (fetchedCats, errorMsg) = await CatAPIManager.shared.fetchCats(tags: tags, pageSkip: self.pageSkip)
            DispatchQueue.main.async {
                if !fetchedCats.isEmpty {
                    self.cats.append(contentsOf: fetchedCats)
                    self.pageSkip += fetchedCats.count
                } else {
                    self.errorMessage = errorMsg
                }

                self.fetchingMore = false
            }
        }
    }
    
    func reloadWithTag(_ tag:String) {
        self.tags = tag
        self.cats = []
        
        pageSkip = tag == "" ? Int.random(in: 0...500) : 0
        
        self.fetch()
    }
}
