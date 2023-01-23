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
    
    var filteredBreeds: [CatBreed] {
        self.modelData.breedsList.filter {
            breed in
            (!self.showFavoritesOnly || breed.isFavorite)
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
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        print("Search")
                    }) {
                        Label("Search", systemImage: "magnifyingglass")
                            .foregroundColor(.gray)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showFavoritesOnly.toggle()
                    }) {
                        Label("Favorites", systemImage: self.showFavoritesOnly ? "heart.fill" : "heart")
                            .foregroundColor(self.showFavoritesOnly ? .red : .gray)
                    }
                }
            }
        }
        .onAppear {
            self.modelData.fetchBreeds()
        }
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
                        .padding(.bottom, 10)
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                    if self.breed.isFavorite {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                }
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
