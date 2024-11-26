//
//  BreedListItem.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 10/03/2023.
//

import SwiftUI
import SwiftData

struct BreedListItem: View {
    var breed: CatBreed
    var homePageShowFavoriteOnly: Bool
    
    @State var viewModel: BreedViewModel
    
    init(breed: CatBreed, homePageShowFavoriteOnly: Bool) {
        self.breed = breed
        self.homePageShowFavoriteOnly = homePageShowFavoriteOnly
        self.viewModel = BreedViewModel(catBreed: breed)
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationLink {
            CatBreedDetails(catBreed: self.breed, homePageShowFavoriteOnly: self.homePageShowFavoriteOnly, isFavorite: $viewModel.isFavorite)
        } label: {
            ZStack {
                Color.white
                    .frame(width: 150)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(Color.ui.primaryColor, lineWidth: 1)
                    }
                VStack(alignment: .leading, spacing: 0) {
                    // -- MARK: Reference image of the breed
                    if NetworkMonitor.shared.isConnected && self.breed.image != nil {
                        BreedReferenceAsyncImage(image: self.breed.image)
                            .frame(width: 150, height: 180)
                    }
                    // -- MARK: Name of the breed + fav heart if is fav
                    HStack {
                        Text(self.breed.name)
                            .font(.custom("Asap-Regular", size: 14))
                            .foregroundColor(Color.ui.neutralColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        if self.viewModel.isFavorite {
                            Spacer()
                            Image("heart.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 16)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    // -- MARK: Adding country and attributes chips
                    BreedAttributesList(
                        breed: breed,
                        withCountry: true,
                        chipSize: .small,
                        chipColor: Color.ui.secondaryColor
                    )
                    .padding(.bottom, 8)
                    .padding(.horizontal, 10)
                    // -- TODO: delete Spacer if flexible grid and move vertical padding to VStack spacing
                    Spacer(minLength: 0)
                }
            }
            .frame(width: 150)
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
                    .transition(.opacity)
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
        .frame(width: 150, height: 180)
        .cornerRadius(6)
    }
}

struct BreedListItem_Previews: PreviewProvider {
    static var previews: some View {
        BreedListItem(breed: CatBreed.test, homePageShowFavoriteOnly: false)
            .previewLayout(.sizeThatFits)
    }
}
