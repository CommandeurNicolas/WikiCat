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
    private let realm = try! Realm()
    
    func fetchCatBreed() -> [CatBreed] {
        print("fetchCatBreed")
        return Array(realm.objects(CatBreed.self))
    }
    
    // Compare with local storage and update/create if necessary
    func saveApiCatBreeds(_ apiBreeds: [CatBreed]) {
        print("saveApiCatBreeds")
        self.realm.writeAsync {
            apiBreeds.forEach { breed in
                self.realm.add(breed)
            }
        }
    }
    
    func saveCatBreed(_ catBreed: CatBreed) {
        print("saveCatBreed")
        self.realm.writeAsync {
            // TODO: add modified field ???
            self.realm.add(catBreed)
        }
    }
    
    func clear() {
        self.realm.writeAsync {
            self.realm.deleteAll()
        }
    }
    
}
