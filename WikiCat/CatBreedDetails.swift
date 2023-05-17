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
    
    @State var showMore: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Reference image TODO: change to carousel of multiple images
                // NavBar (Back + favorite buttons)
                ZStack {
                    if NetworkMonitor.shared.isConnected {
                        DetailsImage(imgUrl: self.catBreed.image?.url)
                    }
                    VStack {
                        HStack {
                            RoundBackButton()
                            Spacer()
                            RoundLikeButton(isFavorite: $modelData.breedsList[self.breedIndex].isFavorite)
                        }
                        .padding(15)
                        Spacer()
                    }
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
                    Text(self.catBreed.country_code.flag())
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
                    CatBreedImportantDetails(title: "Life span", description: "\(catBreed.life_span!) Years")
                    Spacer()
                    CatBreedImportantDetails(title: "Weight", description: "\(catBreed.weight!.metric) Kg")
                    Spacer()
                }
                .padding(.vertical, 16)
                
                // Description
                Text(catBreed.description)
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
                    if self.catBreed.hasTemperament {
                        Text("Temperament")
                            .font(.custom("Asap-SemiBold", size: 24))
                            .padding(.top, 16)
                        BreedTemperamentList(
                            temperament: self.catBreed.temperament!,
                            chipSize: .large
                        )
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    }
                    
                    
                    // Characteristics rating
                    Text("Characteristics rating")
                        .font(.custom("Asap-SemiBold", size: 24))
                        .padding(.top, 8)
                    Group {
                        StarRatingDetailField(ratingName: "Affection level", rating: self.catBreed.affection_level)
                        StarRatingDetailField(ratingName: "Lap cat", rating: self.catBreed.lap)
                        StarRatingDetailField(ratingName: "Child friendly", rating: self.catBreed.child_friendly)
                        StarRatingDetailField(ratingName: "Dog friendly", rating: self.catBreed.dog_friendly)
                        StarRatingDetailField(ratingName: "Energy level", rating: self.catBreed.energy_level)
                        StarRatingDetailField(ratingName: "Health issues", rating: self.catBreed.health_issues)
                        StarRatingDetailField(ratingName: "Social needs", rating: self.catBreed.social_needs)
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
                    .scaledToFill()
                    .transition(.opacity)
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .padding()
            @unknown default:
                // TODO: replace with http cats call ? or a default http cat image ?
                EmptyView()
            }
        }
        // TODO: replace with aspectRatio ???
        .frame(width: 363, height: 363)
        .cornerRadius(16)
    }
}

struct CatBreedDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetails(catBreed: CatBreed.test)
            .environmentObject(ModelData())
    }
}
