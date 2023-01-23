//
//  HomePage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

struct HomePage: View {
    @State private var breedsList: [CatBreed] = []
    
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2), spacing: 25) {
                    ForEach(breedsList, id: \.id) {
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
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        print("Favorites")
                    }) {
                        Label("Favorites", systemImage: "heart.fill")
                    }
                }
            }
        }
        .onAppear {
            self.loadBreeds()
        }
    }
    
    private func loadBreeds() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=10") else {
            print("Invalid URL")
            return
        }
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Retrieving API KEY failed")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([CatBreed].self, from: data)
                    DispatchQueue.main.async {
                        self.breedsList = result
                    }
                    return
                } catch { print("breeds error \(error)") }
            }
        }.resume()
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
                Text(self.breed.name)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                    .padding(.bottom, 10)
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
            }
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
                    .background(.red)
                    .foregroundColor(.white)
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
    }
}
