//
//  BreedTemperamentList.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/05/2023.
//

import SwiftUI

struct BreedTemperamentList: View {
    let temperament: String
    let chipSize: ChipTagSize
    
    @State private var attributesList: [String] = []
    
    var body: some View {
        FlexibleRowView(
            data: attributesList,
            spacing: 8,
            alignment: .leading
        ) {
            item in
            ChipTag(
                text: item,
                color: Color.ui.primaryColor,
                chipSize: self.chipSize
            )
        }
        .onAppear {
            attributesList.removeAll()
            attributesList = self.temperament.components(separatedBy: ", ")
        }
    }
}

struct BreedTemperamentList_Previews: PreviewProvider {
    static var previews: some View {
        BreedTemperamentList(temperament: CatBreed.test.temperament!, chipSize: .large)
    }
}
