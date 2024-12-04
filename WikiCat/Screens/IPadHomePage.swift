//
//  IPadHomePage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import SwiftUI
import SwiftData

struct IPadHomePage: View {
    @State private var showFavoritesOnly: Bool = false
    
    @State private var openSearchBar: Bool = false
    @State var searchText: String = ""
    
    @Query(sort: \CatBreed.name, order: .forward) private var catBreeds: [CatBreed]
    @State var selectedBreed: CatBreed?
    
    var filteredBreeds: [CatBreed] {
        if openSearchBar && searchText != "" {
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
            List(filteredBreeds, selection: $selectedBreed) { breed in
                NavigationLink {
                    CatBreedDetailsIPad(catBreed: breed)
                } label: {
                    Text(breed.name)
                        .font(.title)
                }
            }
        } detail: {
            Text("Select a cat breed to see its details.")
        }
        .ignoresSafeArea()
        .background(Color.ui.backgroundColor)
    }
}

struct IPadHomePage_Previews: PreviewProvider {
    static var previews: some View {
        IPadHomePage()
            .environmentObject(ModelData())
    }
}
