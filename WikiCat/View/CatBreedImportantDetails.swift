//
//  CatBreedImportantDetails.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 12/05/2023.
//

import SwiftUI

struct CatBreedImportantDetails: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .center) {
            Text(title)
                .font(.custom("Asap-Medium", size: 12))
            Spacer(minLength: 15.0)
            Text(description)
                .font(.custom("Asap-Bold", size: 14))
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 25)
        .frame(width: 100, height: 100)
        .background(Color.ui.backgroundColor)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.ui.primaryColor, lineWidth: 1)
        )
//        .overlay {
//            RoundedRectangle(cornerRadius: 24)
//                .fill(Color.ui.backgroundColor)
//                .bor
//        }
        
    }
}

struct CatBreedImportantDetails_Previews: PreviewProvider {
    static var previews: some View {
        CatBreedImportantDetails(title: "Life span", description: "14 - 15 years")
//            .frame(width: 100, height: 100)
    }
}
