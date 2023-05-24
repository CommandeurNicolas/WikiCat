//
//  CatBreedDetailsSnippetView.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 11/05/2023.
//

import SwiftUI

struct CatBreedDetailsSnippetView: View {
    let catBreed: CatBreed
    let referenceImage: UIImage?
    
    var body: some View {
        VStack {
            if let referenceImage = referenceImage {
                Image(uiImage: referenceImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
            }
            VStack(alignment: .leading) {
                // MARK: Important infos
                HStack {
                    Text(self.catBreed.name)
                        .font(.title)
                    Spacer()
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
                
                // MARK: More infos / description
                Divider()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                Text("More infos")
                    .font(.title2)
                    .padding(.bottom, 10)
                Text(self.catBreed.breedDescription)
                    .frame(maxHeight: .infinity)
                
                // MARK: Breed characteristics
                // TODO: replace breed characteristics by "Open app to see more"
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
                // MARK: ---------------------------------------------------------
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer()
        }
        
    }
}



//struct CatBreedDetailsSnippetView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatBreedDetailsSnippetView(catBreed: , referenceImage: <#T##UIImage?#>)
//    }
//}
