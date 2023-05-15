//
//  RoundButtons.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 12/05/2023.
//

import SwiftUI

struct RoundBackButton: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .scaleEffect(1.5)
                .frame(width: 24, height: 24)
                .foregroundColor(Color.ui.backgroundColor)
        }
        .frame(width: 44, height: 44)
        .background(Color.ui.primaryColor.opacity(0.5))
        .containerShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.ui.primaryColor, lineWidth: 1)
        )
    }
}
struct RoundLikeButton: View {
    @Binding var isFavorite: Bool
    
    var body: some View {
        Button {
            self.isFavorite.toggle()
        } label: {
            ZStack {
                if self.isFavorite {
                    Image("heart.fill")
                        .resizable()
                }
                Image("heart")
                    .resizable()
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .foregroundColor(Color.ui.backgroundColor)
        }
        .frame(width: 44, height: 44)
        .background(Color.ui.primaryColor.opacity(0.5))
        .containerShape(Capsule())
        .overlay(
            Capsule()
                .stroke(Color.ui.primaryColor, lineWidth: 1)
        )
    }
}

struct RoundButtons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundBackButton()
            RoundLikeButton(isFavorite: .constant(false))
            RoundLikeButton(isFavorite: .constant(true))
        }
        .previewLayout(.sizeThatFits)
    }
}
