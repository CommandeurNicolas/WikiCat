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
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 25) {
                    ForEach(self.filteredBreeds, id: \.id) {
                        breed in
                        BreedListItem(breed: breed)
                            .shadow(color: .gray, radius: 5, x: 2, y: 2)
                    }
                }
                .padding()
            }
            .navigationTitle("WikiCat 🐱")
            .navigationBarTitleDisplayMode(.large)
            .listStyle(.grouped)
            .padding()
            // TODO: add .refreshable to reload breeds list and/or reload thumbnails
            .toolbar {
                if !self.openSearchBar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            self.openSearchBar.toggle()
                        }) {
                            Label("Search", systemImage: "magnifyingglass")
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 10)
                    }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.showFavoritesOnly.toggle()
                        }) {
                            Label("Favorites", systemImage: self.showFavoritesOnly ? "heart.fill" : "heart")
                                .foregroundColor(self.showFavoritesOnly ? .red : .gray)
                        }
                        .padding(.top, 10)
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
        }
        .onAppear {
            self.loadBreeds()
        }
    }
    
    private func loadBreeds() {
        self.modelData.fetchBreeds()
    }
}

struct BreedListItem: View {
    let breed: CatBreed!
    
    var body: some View {
        NavigationLink {
            CatBreedDetails(catBreed: self.breed)
        } label: {
            VStack {
                BreedReferenceAsyncImage(image: self.breed.image)
                    .padding(.top, 5)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                HStack {
                    Text(self.breed.name)
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)
                        .lineLimit(2)
                        .truncationMode(.tail)
                    if self.breed.isFavorite {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
            }
            .frame(width: 135)
            .background(.white)
            .cornerRadius(10)
        }
    }
}

struct BreedReferenceAsyncImage: View {
    let image: CatImage!
    
    var body: some View {
        AsyncImage(url: URL(string: self.image.url), transaction: Transaction(animation: .spring())) {
            phase in
            switch phase {
            case .empty:
                ProgressView()
                    .font(.largeTitle)
                    .padding()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.slide)
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .padding()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 125, height: 125)
        .cornerRadius(5)
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
            .environmentObject(ModelData())
    }
}
