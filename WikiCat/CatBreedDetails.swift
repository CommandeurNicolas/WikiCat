//
//  CatBreedDetails.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 19/01/2023.
//

import SwiftUI

struct CatBreedDetails: View {
    @EnvironmentObject var modelData: ModelData
    let catBreed: CatBreed
    
    var breedIndex: Int {
        modelData.breedsList.firstIndex(where: {$0.id == catBreed.id})!
    }
    
    var body: some View {
        ScrollView {
            VStack {
                DetailsImage(imgUrl: self.catBreed.image?.url)
                VStack(alignment: .leading) {
                    // MARK: Important infos
                    HStack {
                        Text(self.catBreed.name)
                            .font(.title)
                        Spacer()
                        FavoriteHeart(isFavorite: $modelData.breedsList[self.breedIndex].isFavorite)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Lifespan -")
                            .bold()
                        Text("\(self.catBreed.life_span ?? "? - ?") years")
                        Spacer()
                        Text("Weigth -")
                            .bold()
                        Text("\(self.catBreed.weight?.metric ?? "? - ?") Kg")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    // MARK: More infos / description
                    Divider()
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    Text("More infos")
                        .font(.title2)
                        .padding(.bottom, 10)
                    Text(self.catBreed.description)
                    
                    // MARK: Breed characteristics
                    Divider()
                        .padding(.top, 20)
                        .padding(.bottom, 10)
                    Text("Breed characteristics")
                        .font(.title2)
                    Group {
                        StarRatingDetailField(ratingName: "Affection level", rating: self.catBreed.affection_level)
                        StarRatingDetailField(ratingName: "Lap cat", rating: self.catBreed.lap)
                        StarRatingDetailField(ratingName: "Child friendly", rating: self.catBreed.child_friendly)
                        StarRatingDetailField(ratingName: "Dog friendly", rating: self.catBreed.dog_friendly)
                        StarRatingDetailField(ratingName: "Energy level", rating: self.catBreed.energy_level)
                        StarRatingDetailField(ratingName: "Health issues", rating: self.catBreed.health_issues)
                        StarRatingDetailField(ratingName: "Social needs", rating: self.catBreed.social_needs)
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 5)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}


struct DetailsImage: View {
    let imgUrl: String!
    
    // TODO: Sauvegarder l'image et stocket son chemin et une instance Image dans CatBreed
    
    var body: some View {
        AsyncImage(url: URL(string: self.imgUrl), transaction: Transaction(animation: .spring())) {
            phase in
            switch phase {
            case .empty:
                ProgressView()
                    .font(.largeTitle)
                    .padding()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .transition(.slide)
                    .frame(maxWidth: 300)
                    .cornerRadius(5)
                    .shadow(radius: 7)
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
            @unknown default:
                Image(systemName: "exclamationmark.icloud")
            }
        }
        .padding()
    }
}

struct StarRatingDetailField: View {
    let ratingName: String!
    let rating: Int?
    
    var body: some View {
        if self.rating != nil {
            HStack {
                Text(self.ratingName)
                    .lineLimit(1)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.gray)
                Spacer()
                StarRating(rating: self.rating!)
                    .foregroundColor(.yellow)
            }
        }
    }
}


struct CatBreedDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetails(catBreed: ModelData().breedsList[0])
    }
}
