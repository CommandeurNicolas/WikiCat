//
//  CatBreedDetails.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 19/01/2023.
//

import SwiftUI
import SwiftData

struct CatBreedDetails: View {
    let catBreed: CatBreed
    var homePageShowFavoriteOnly: Bool
    
    @Binding var isFavorite: Bool
    
    @State var showMore: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Reference image TODO: change to carousel of multiple images
                // NavBar (Back + favorite buttons)
                ZStack(alignment: .top) {
                    if NetworkMonitor.shared.isConnected && self.catBreed.image != nil {
                        DetailsImage(imgUrl: self.catBreed.image?.url)
                    }
                    HStack {
                        RoundBackButton()
                        Spacer()
                        RoundLikeButton(catBreedId: self.catBreed.id, homePageShowFavoriteOnly: self.homePageShowFavoriteOnly, isFavorite: $isFavorite)
                    }
                    .padding(16)
                }
                // Name
                Text(self.catBreed.name)
                    .padding(.top, 16)
                    .font(.custom("Asap-SemiBold", size: 24))
                    .foregroundColor(Color.ui.neutralColor)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .truncationMode(.tail)
                
                // Country
                HStack {
                    Text(self.catBreed.countryCode.flag())
                    Text(self.catBreed.origin)
                        .font(.custom("Asap-Regular", size: 16))
                        .foregroundColor(Color.ui.neutralColor)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                
                // Important details (life span and weight)
                HStack(alignment: .center) {
                    Spacer()
                    CatBreedImportantDetails(title: "Life span", description: "\(catBreed.lifeSpan) Years")
                    Spacer()
                    CatBreedImportantDetails(title: "Weight", description: "\(catBreed.weight.metric) Kg")
                    Spacer()
                }
                .padding(.vertical, 16)
                
                // Description
                Text(catBreed.catDescription)
                    .font(.custom("Asap-Regular", size: 12))
                    .foregroundColor(Color.ui.neutralVariantColor)
                
                // Show more details
                if showMore {
                    // Attributes chips
                    if self.catBreed.hasAttributes {
                        Text("Attributes")
                            .font(.custom("Asap-SemiBold", size: 24))
                            .padding(.top, 16)
                        BreedAttributesList(
                            breed: self.catBreed,
                            withCountry: false,
                            chipSize: .large,
                            chipColor: Color.ui.primaryColor
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    }
                    
                    // Temperament chips
                    Text("Temperament")
                        .font(.custom("Asap-SemiBold", size: 24))
                        .padding(.top, 16)
                    BreedTemperamentList(
                        temperament: self.catBreed.temperament,
                        chipSize: .large
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                    
                    // Characteristics rating
                    Text("Characteristics rating")
                        .font(.custom("Asap-SemiBold", size: 24))
                        .padding(.top, 8)
                    Group {
                        StarRatingDetailField(ratingName: "Affection level", rating: self.catBreed.affectionLevel)
                        StarRatingDetailField(ratingName: "Lap cat", rating: self.catBreed.lap)
                        StarRatingDetailField(ratingName: "Child friendly", rating: self.catBreed.childFriendly)
                        StarRatingDetailField(ratingName: "Dog friendly", rating: self.catBreed.dogFriendly)
                        StarRatingDetailField(ratingName: "Energy level", rating: self.catBreed.energyLevel)
                        StarRatingDetailField(ratingName: "Health issues", rating: self.catBreed.healthIssues)
                        StarRatingDetailField(ratingName: "Social needs", rating: self.catBreed.socialNeeds)
                    }
                }
                // Show more button
                HStack {
                    ShowMoreButton(showMore: $showMore)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
                .padding(.bottom, 20)
            }
            .padding(.top, 70)
            .padding(.horizontal, 15)
        }
        .toolbar(.hidden, for: .navigationBar)
        .ignoresSafeArea()
        .background(Color.ui.backgroundColor)
    }
}

//struct CatBreedDetails_Previews: PreviewProvider {
//    static var previews: some View {
//        CatBreedDetails(catBreed: CatBreed.test, homePageShowFavoriteOnly: false)
//            .environmentObject(ModelData())
//    }
//}
