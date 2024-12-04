//
//  StarRating.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 19/01/2023.
//

import SwiftUI

struct StarRatingDetailField: View {
    let ratingName: String!
    let rating: Int?
    var visionStyle: Bool = false
    
    var body: some View {
        if self.rating != nil {
            HStack {
                Text(self.ratingName)
                    .lineLimit(1)
                    .font(.custom("Asap-Regular", size: visionStyle ? 18 : 14))
                    .foregroundColor(visionStyle ? Color.white : Color.ui.neutralVariantColor)
                Spacer()
                StarRating(rating: self.rating!, visionStyle: self.visionStyle)
            }
            .padding(.horizontal, 15)
        }
    }
}

private struct StarRating: View {
    let rating: Int!
    var visionStyle: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            let halfRating: Float = Float(self.rating)/2
            if halfRating != 0 && halfRating != 0.5 {
                ForEach(1...Int(halfRating), id: \.self) {
                    number in
                    Image(systemName: "star.fill")
                        .frame(width: 10, height: 10)
                        .foregroundColor(visionStyle ? Color.yellow : Color.ui.primaryColor)
                }
            }
            if halfRating < 5 && halfRating - Float(Int(halfRating)) >= 0.5 {
                Image(systemName: "star.leadinghalf.filled")
                    .frame(width: 10, height: 10)
                    .foregroundColor(visionStyle ? Color.yellow : Color.ui.primaryColor)
            }
            ForEach(Int(halfRating+1.5)...5, id: \.self) {
                number in
                Image(systemName: "star")
                    .frame(width: 10, height: 10)
                    .foregroundColor(visionStyle ? Color.white : Color.ui.secondaryColor)
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 4, visionStyle: false)
        StarRating(rating: 4, visionStyle: true)
    }
}
