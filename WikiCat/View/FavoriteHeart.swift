//
//  FavoriteHeart.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 20/01/2023.
//

import SwiftUI

struct FavoriteHeart: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button {
            self.isFavorite.toggle()
        } label: {
            Label("Toggle favorite", systemImage: self.isFavorite ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(self.isFavorite ? .red : .gray)
        }
    }
}

struct FavoriteHeart_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteHeart(isFavorite: .constant(true))
    }
}
