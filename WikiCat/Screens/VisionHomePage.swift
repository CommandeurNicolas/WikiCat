//
//  VisionHomePage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import SwiftUI
import SwiftData

struct VisionHomePage: View {
    @State private var showFavoritesOnly: Bool = false
    @State var searchText: String = ""
    
    @Query(sort: \CatBreed.name, order: .forward) private var catBreeds: [CatBreed]
    
    var filteredBreeds: [CatBreed] {
        if searchText != "" {
            return catBreeds.filter {
                breed in
                breed.name.uppercased().contains(searchText.uppercased())
            }
        } else {
            return self.catBreeds.filter {
                breed in
                (!self.showFavoritesOnly || breed.isFavorite)
            }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List(filteredBreeds) { breed in
                    NavigationLink {
                        CatBreedDetailsIPad(catBreed: breed, visionStyle: true)
                    } label: {
                        Text(breed.name)
                            .font(.title)
                    }
                    
                }
            }
            .padding()
            .navigationTitle("Cat breeds")
        } detail: {
            Text("Select a cat breed to see its details.")
        }
        .navigationTitle("Cat breeds")
        .searchable(text: $searchText, placement: .sidebar)
    }
}
