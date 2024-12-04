//
//  CatBreedDetailsIPad.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import SwiftUI

struct CatBreedDetailsIPad: View {
    let catBreed: CatBreed
    var visionStyle: Bool = false
    
    var body: some View {
        HStack {
            VStack {
                DetailsImage(imgUrl: self.catBreed.image?.url)
                    .padding(16)
                // Description
                Text(catBreed.catDescription)
                    .font(.custom("Asap-Regular", size: 18))
                    .foregroundColor(visionStyle ? Color.white : Color.ui.neutralVariantColor)
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
                    .font(.custom("Asap-SemiBold", size: 24))
                    .fontWeight(.bold)
                    .foregroundColor(visionStyle ? Color.white : Color.ui.neutralColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                // Important details (life span and weight)
                HStack(alignment: .center) {
                    Spacer()
                    CatBreedImportantDetails(
                        title: "Origin",
                        description: "\(self.catBreed.countryCode.flag()) \(self.catBreed.origin)",
                        visionStyle: visionStyle
                    )
                        // TODO: add click action --> open world 3D Model in a separate WindowGroup
                    Spacer()
                    CatBreedImportantDetails(
                        title: "Life span",
                        description: "\(catBreed.lifeSpan) Years",
                        visionStyle: visionStyle
                    )
                    Spacer()
                    CatBreedImportantDetails(
                        title: "Weight",
                        description: "\(catBreed.weight.metric) Kg",
                        visionStyle: visionStyle
                    )
                    Spacer()
                }
                .padding(.bottom, 24)
                
                // Characteristics rating
                Text("Characteristics rating")
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Group {
                    StarRatingDetailField(
                        ratingName: "Affection level",
                        rating: self.catBreed.affectionLevel,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Lap cat",
                        rating: self.catBreed.lap,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Child friendly",
                        rating: self.catBreed.childFriendly,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Dog friendly",
                        rating: self.catBreed.dogFriendly,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Energy level",
                        rating: self.catBreed.energyLevel,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Health issues",
                        rating: self.catBreed.healthIssues,
                        visionStyle: visionStyle
                    )
                    StarRatingDetailField(
                        ratingName: "Social needs",
                        rating: self.catBreed.socialNeeds,
                        visionStyle: visionStyle
                    )
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
        .background(Color.ui.backgroundColor)
    }
}
