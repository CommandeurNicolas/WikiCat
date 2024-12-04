//
//  DetailsImage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 02/12/2024.
//

import SwiftUI

struct DetailsImage: View {
    let imgUrl: String!
    
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
        .cornerRadius(16)
    }
}
