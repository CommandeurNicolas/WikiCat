//
//  BreedAttributesList.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/05/2023.
//

import SwiftUI

struct BreedAttributesList: View {
    let breed: CatBreed
    let withCountry: Bool
    let chipSize: ChipTagSize
    let chipColor: Color
    
    @State private var attributesList: [String] = []
    
    private var spacingSize: CGFloat {
        switch chipSize {
        case .small:
            return 4.0
        case .large:
            return 8.0
        }
    }
    
    var body: some View {
        FlexibleRowView(
            data: attributesList,
            spacing: self.spacingSize,
            alignment: .leading
        ) {
            item in
            attributesList.firstIndex(of: item) == 0 && withCountry
            ? ChipTag(text: item, color: Color.ui.originChipColor, chipSize: self.chipSize)
            : ChipTag(text: item, color: self.chipColor, chipSize: self.chipSize)
        }
        .onAppear {
            attributesList.removeAll()
            if withCountry {
                let countryFlag = breed.country_code.flag()
                var countryName = ""
                switch(breed.origin) {
                case "United State":
                    countryName = "US"
                case "United Kingdom":
                    countryName = "UK"
                default:
                    countryName = breed.origin
                }
                let countryChipText = "\(countryFlag) \(countryName)"
                attributesList.append(countryChipText)
            }
            
            if breed.isExperimental {
                attributesList.append("Experimental")
            }
            if breed.isHairless {
                attributesList.append("Hairless")
            }
            if breed.isNatural {
                attributesList.append("Natural")
            }
            if breed.isRare {
                attributesList.append("Rare")
            }
            if breed.isRex {
                attributesList.append("Rex")
            }
            if breed.hasSuppressedTail {
                attributesList.append("Suppressed tail")
            }
            if breed.hasShortLegs {
                attributesList.append("Short legs")
            }
            if breed.isHypoallergenic {
                attributesList.append("Hypoallergenic")
            }
        }
    }
}

struct BreedAttributesList_Previews: PreviewProvider {
    static var previews: some View {
        BreedAttributesList(
            breed: CatBreed.test,
            withCountry: true,
            chipSize: .small,
            chipColor: Color.ui.primaryColor
        )
    }
}
