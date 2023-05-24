//
//  HomePage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI
import RealmSwift

struct HomePage: View {
    @ObservedResults(CatBreed.self) var localCatBreeds
    
    @State private var showFavoritesOnly: Bool = false
    
    @State private var openSearchBar: Bool = false
    @State var searchText: String = ""
    
    private var catBreeds: [CatBreed] {
        return Array(localCatBreeds)
    }
    
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
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                CustomTopAppBar(
                    openSearchBar: $openSearchBar,
                    searchText: $searchText,
                    showFavoritesOnly: $showFavoritesOnly
                )
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    ForEach(self.filteredBreeds, id: \.id) {
                        breed in
                        BreedListItem(breed: breed, homePageShowFavoriteOnly: self.showFavoritesOnly)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 32)
            }
            .listStyle(.grouped)
            .ignoresSafeArea()
            .background(Color.ui.backgroundColor)
            // TODO: add .refreshable to reload breeds list and/or reload thumbnails
        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(ModelData())
    }
}
