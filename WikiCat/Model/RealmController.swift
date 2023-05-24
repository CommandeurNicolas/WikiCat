//
//  RealmController.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 16/05/2023.
//

import Foundation
import RealmSwift

struct RealmController {
    static let shared = RealmController()
    
    func fetchCatBreed() -> [CatBreed] {
        let realm = try! Realm()
        return Array(realm.objects(CatBreed.self))
    }
    
    // Compare with local storage and update/create if necessary
    func saveApiCatBreeds(_ apiBreeds: [CatBreed]) {
        let realm = try! Realm()
        let localBreeds = fetchCatBreed()
        try! realm.write {
            apiBreeds.forEach { apiBreed in
                let sameLocalBreedAsAPI = localBreeds.first(where: { localBreed in
                    localBreed == apiBreed
                })
                if sameLocalBreedAsAPI == nil {
                    realm.add(apiBreed)
                }
            }
        }
    }
    
    func clear() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
}
