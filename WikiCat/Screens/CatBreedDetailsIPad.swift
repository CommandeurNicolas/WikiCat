//
//  CatBreedDetailsIPad.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import SwiftUI

struct CatBreedDetailsIPad: View {
    let catBreed: CatBreed
    
    var body: some View {
        HStack {
            VStack {
                DetailsImage(imgUrl: self.catBreed.image?.url)
                    .padding(16)
//                Spacer()
                // Description
                Text(catBreed.catDescription)
                    .multilineTextAlignment(.leading)
                    .padding(16)
                Spacer()
            }
            .frame(minWidth: 300)
            .padding(.trailing, 24)
            
            VStack {
                // Name
                Text(self.catBreed.name)
                    .padding(.top, 24)
                    .font(.system(size: 48))
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .truncationMode(.tail)
                
                // Important details (life span and weight)
                HStack(alignment: .center) {
                    Spacer()
                    CatBreedImportantDetails(title: "Origin", description: "\(self.catBreed.countryCode.flag()) \(self.catBreed.origin) ")
                        // TODO: add click action --> open world 3D Model in a separate WindowGroup
                    Spacer()
                    CatBreedImportantDetails(title: "Life span", description: "\(catBreed.lifeSpan) Years")
                    Spacer()
                    CatBreedImportantDetails(title: "Weight", description: "\(catBreed.weight.metric) Kg")
                    Spacer()
                }
                .padding(.bottom, 24)
                
                // Characteristics rating
                Text("Characteristics rating")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Group {
                    StarRatingDetailField(ratingName: "Affection level", rating: self.catBreed.affectionLevel)
                    StarRatingDetailField(ratingName: "Lap cat", rating: self.catBreed.lap)
                    StarRatingDetailField(ratingName: "Child friendly", rating: self.catBreed.childFriendly)
                    StarRatingDetailField(ratingName: "Dog friendly", rating: self.catBreed.dogFriendly)
                    StarRatingDetailField(ratingName: "Energy level", rating: self.catBreed.energyLevel)
                    StarRatingDetailField(ratingName: "Health issues", rating: self.catBreed.healthIssues)
                    StarRatingDetailField(ratingName: "Social needs", rating: self.catBreed.socialNeeds)
                }
                
                // Temperament chips
                Text("Attributes")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 24)
                BreedTemperamentList(
                    temperament: self.catBreed.temperament,
                    chipSize: .large
                )
                
                Spacer()
            }
            .frame(minWidth: 400, alignment: .leading)
        }
        .padding()
    }
}
