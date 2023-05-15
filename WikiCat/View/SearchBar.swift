//
//  SearchBar.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 21/01/2023.
//

import SwiftUI

struct SearchBar : View {
    @Binding var searchText: String
    let cancelAction: () -> Void
    @State private var isEditing = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                TextField("Breed name (ex: Siamese)", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding(.vertical, 10)
                    .onTapGesture {
                        self.isEditing = true
                    }
                if self.isEditing && self.searchText != "" {
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 10)
                    }
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            Button(action: {
                self.isEditing = false
                self.searchText = ""
                self.cancelAction()
            }) {
                Text("Cancel")
            }
            .padding(.trailing, 10)
            .transition(.move(edge: .trailing))
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("aezaz"), cancelAction: { print("coucou") })
    }
}
