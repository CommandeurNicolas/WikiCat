//
//  CatBreedDetails.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 19/01/2023.
//

import SwiftUI

struct CatBreedDetails: View {
    let catBreed: CatBreed!
    
    var body: some View {
        VStack {
            DetailsImage(imgUrl: self.catBreed.image?.url)
            VStack(alignment: .leading) {
                Text(self.catBreed.name)
                    .font(.title)
                HStack {
                    Text(self.catBreed.origin)
                    Spacer()
                    Text(self.catBreed.alt_names ?? "")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.vertical, 10)
                .padding(.horizontal, 5)
                
                Divider()
                Text("More infos")
                    .font(.title2)
                    .padding(.vertical, 10)
                Text(self.catBreed.description)
            }
            .padding()
            
            Spacer()
        }
    }
}


struct DetailsImage: View {
    let imgUrl: String!
    
    // TODO: Afficher l'image de l'objet LegoSet
    
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


struct CatBreedDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedDetails(catBreed: CatBreed.test)
    }
}
