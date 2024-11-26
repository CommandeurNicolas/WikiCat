//
//  CatBreedRepository.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/11/2024.
//

import Foundation
import SwiftData

@ModelActor
actor DataRepository {
    public static let shared = DataRepository()
    
    private var context: ModelContext { modelExecutor.modelContext }
    
    private init() {
        let schema = Schema([CatBreed.self, CatWeight.self, CatImage.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        guard let container = try? ModelContainer(for: schema, configurations: modelConfiguration) else {
            // TODO: Check if it's crashing here when database model change, if so try to clean SwiftData DB
            fatalError("Could not create the ModelContainer, please verify")
        }
        self.init(modelContainer: container)
    }
    
    func isDatabaseEmpty() -> Bool {
        do {
            let shouldFetch = try context.fetch(FetchDescriptor<CatBreed>()).isEmpty
            debugPrint("[DataRepository] IS DB EMPTY \(shouldFetch)")
            return shouldFetch
        } catch {
            fatalError("[DataRepository] IS DB EMPTY error \(error.localizedDescription)")
        }
    }
    
    func insert(catBreeds: [CatBreed]) {
        var index = 0
        do {
            try catBreeds.forEach {
                context.insert($0)
                if (context.hasChanges) {
                    try context.save()
                }  else {
                    debugPrint("[DataRepository] INSERT nothing changed")
                }
                debugPrint("[DataRepository] INSERT index=\(index) success ✅")
                index += 1
            }
        } catch {
            fatalError("[DataRepository] INSERT index=\(index) error \(error.localizedDescription)")
        }
    }
    
    func updateIfNeeded(apiCatBreeds: [CatBreed]) {
        let databaseCatBreeds = try? context.fetch(FetchDescriptor<CatBreed>())
        apiCatBreeds.forEach { apiBreed in
            let dbMatchingBreed = databaseCatBreeds?.first(where: { $0.id == apiBreed.id })
            if (dbMatchingBreed == nil || apiBreed == dbMatchingBreed) {
                updateCatBreed(newCatBreed: apiBreed)
            }
        }
    }
    
    func updateCatBreed(newCatBreed catBreed: CatBreed) {
        context.insert(catBreed)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func isBreedFavorite(catBreedId: String) -> Bool {
        do {
            let catBreed = try context.fetch(FetchDescriptor<CatBreed>(predicate: #Predicate { $0.id == catBreedId })).first
            return catBreed?.isFavorite ?? false
        } catch {
            print("error \(error.localizedDescription)")
            return false
        }
    }
    
    func toggleFavorite(catBreedId: String) {
        do {
            let catBreed = try context.fetch(FetchDescriptor<CatBreed>(predicate: #Predicate { $0.id == catBreedId })).first
            catBreed?.isFavorite.toggle()
            try context.save()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getDescriptor(catBreedId: String) -> FetchDescriptor<CatBreed> {
        return FetchDescriptor<CatBreed>(predicate: #Predicate { $0.id == catBreedId })
    }
}
