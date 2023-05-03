//
//  HomePage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

struct HomePage: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly: Bool = false
    
    @State private var openSearchBar: Bool = false
    @State var searchText: String = ""
    
    var filteredBreeds: [CatBreed] {
        if openSearchBar && searchText != "" {
            return self.modelData.breedsList.filter {
                breed in
                breed.name.contains(searchText)
            }
        } else {
            return self.modelData.breedsList.filter {
                breed in
                (!self.showFavoritesOnly || breed.isFavorite)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 16) {
                    ForEach(self.filteredBreeds, id: \.id) {
                        breed in
                        BreedListItem(breed: breed)
                    }
                }
                .padding()
            }
            .navigationTitle("WikiCat")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.grouped)
//            .padding()
            // TODO: add .refreshable to reload breeds list and/or reload thumbnails
            .toolbar {
                if !self.openSearchBar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            self.openSearchBar.toggle()
                        }) {
                            Image("search")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 44)
                                .foregroundColor(Color.ui.primaryColor)
                        }
//                        .padding(.vertical, 32)
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showFavoritesOnly.toggle()
                        }) {
                            Image(self.showFavoritesOnly ? "heart.fill" : "heart")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 44, height: 44)
                                .foregroundColor(Color.ui.primaryColor)
                        }
//                        .padding(.vertical, 32)
                    }
                } else {
                    ToolbarItemGroup(placement: .principal) {
                        SearchBar(searchText: $searchText, cancelAction: {
                            self.openSearchBar.toggle()
                        })
                        .padding(.top, 10)
                        .transition(.move(edge: .leading))
                        .animation(.easeInOut(duration: 3.0), value: self.openSearchBar)
//                            .padding(.top, -30)
                    }
                }
            }
            .background(Color.ui.backgroundColor)
        }
        .task {
            await self.loadBreeds()
        }
    }
    
    private func loadBreeds() async {
        await self.modelData.fetchBreeds()
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(ModelData())
    }
}
