//
//  DetailsViewModel.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 19/11/2024.
//

import SwiftUI
import SwiftData

class BreedViewModel: ObservableObject {
    @Published var isFavorite: Bool
    
    init(catBreed: CatBreed) {
        isFavorite = catBreed.isFavorite
        Task {
            await fetchIsBreedInFavorite(catBreedId: catBreed.id)
        }
    }

    private func fetchIsBreedInFavorite(catBreedId: String) async {
        self.isFavorite = await DataRepository.shared.isBreedFavorite(catBreedId: catBreedId)
    }
    
    func toggleIsFavorite(catBreedId: String) {
        isFavorite.toggle()
        Task {
            await DataRepository.shared.toggleFavorite(catBreedId: catBreedId)
        }
    }
}
