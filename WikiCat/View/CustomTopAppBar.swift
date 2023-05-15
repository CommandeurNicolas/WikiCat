//
//  CustomTopAppBar.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 12/05/2023.
//

import SwiftUI

struct CustomTopAppBar: View {
    @Binding var openSearchBar: Bool
    @Binding var searchText: String
    @Binding var showFavoritesOnly: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if !self.openSearchBar {
                    Button(action: {
                        self.openSearchBar.toggle()
                    }) {
                        Image("search")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 44)
                            .foregroundColor(Color.ui.primaryColor)
                    }
                    Spacer()
                    Button(action: {
                        self.showFavoritesOnly.toggle()
                    }) {
                        Image(self.showFavoritesOnly ? "heart.fill" : "heart")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                            .foregroundColor(Color.ui.primaryColor)
                    }
                } else {
                    SearchBar(searchText: $searchText, cancelAction: {
                        self.openSearchBar.toggle()
                    })
                    .font(.custom("Asap-Regular", size: 16))
                    .padding(.top, 10)
                    .transition(.move(edge: .leading))
                    .animation(.easeInOut(duration: 3.0), value: self.openSearchBar)
                }
            }
            /* TODO: title must :
             *      1- Slide between icons ?
             *      2- Disappear ?
             */
//            if !self.openSearchBar {
                Text("WikiCat")
                    .font(.custom("Asap-SemiBold", size: 48))
//            }
        }
        .padding(.top, 50)
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
    }
}

struct CustomTopAppBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTopAppBar(
            openSearchBar: .constant(false),
            searchText: .constant(""),
            showFavoritesOnly: .constant(false)
        )
        .previewDisplayName("Default top app bar")
        CustomTopAppBar(
            openSearchBar: .constant(true),
            searchText: .constant(""),
            showFavoritesOnly: .constant(false)
        )
        .previewDisplayName("Open search bar")
        CustomTopAppBar(
            openSearchBar: .constant(true),
            searchText: .constant("Balinese"),
            showFavoritesOnly: .constant(false)
        )
        .previewDisplayName("Search for Balinese")
        CustomTopAppBar(
            openSearchBar: .constant(false),
            searchText: .constant(""),
            showFavoritesOnly: .constant(true)
        )
        .previewDisplayName("Show favorite")
    }
}
