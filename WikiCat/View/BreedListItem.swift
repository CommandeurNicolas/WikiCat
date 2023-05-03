//
//  BreedListItem.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 10/03/2023.
//

import SwiftUI

struct BreedListItem: View {
    let breed: CatBreed!
    
    var body: some View {
        NavigationLink {
            CatBreedDetails(catBreed: self.breed)
        } label: {
            ZStack {
                Color.white
                    .frame(width: 150)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .strokeBorder(Color.ui.primaryColor, lineWidth: 1)
                    }
                VStack(alignment: .leading, spacing: 0) {
                    // -- MARK: Reference image of the breed
                    if self.breed.image != nil {
                        BreedReferenceAsyncImage(image: self.breed.image)
                            .frame(width: 150, height: 180)
                    }
//                    BreedReferenceAsyncImage(image: self.breed.image)
//                        .frame(width: 150, height: 180)
                    // -- MARK: Name of the breed + fav heart if is fav
                    HStack {
                        Text(self.breed.name)
                            .font(.custom("Asap-Regular", size: 14))
                            .foregroundColor(Color.ui.neutralColor)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .truncationMode(.tail)
                        if self.breed.isFavorite {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 10)
                    // -- MARK: Adding country and trait chips
                    BreedTraitList(breed: breed)
                        .padding(.bottom, 8)
                        .padding(.horizontal, 10)
                    // -- TODO: delete Spacer if flexible grid and move vertical padding to VStack spacing
                    Spacer(minLength: 0)
                }
            }
            .frame(width: 150)
        }
    }
}

struct BreedReferenceAsyncImage: View {
    let image: CatImage!
    
    var body: some View {
        AsyncImage(url: URL(string: self.image.url), transaction: Transaction(animation: .spring())) {
            phase in
            switch phase {
            case .empty:
                ProgressView()
                    .font(.largeTitle)
                    .padding()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .transition(.slide)
            case .failure(_):
                Image(systemName: "exclamationmark.icloud")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.red)
                    .padding()
            @unknown default:
                EmptyView()
            }
        }
        .frame(width: 150, height: 180)
        .cornerRadius(6)
    }
}

struct BreedTraitList: View {
    let breed: CatBreed!
    
    @State private var traitList: [String] = []
    
    var body: some View {
        FlexibleView(data: traitList, spacing: 4, alignment: .leading) {
            item in
            traitList.firstIndex(of: item) == 0
            ? TraitChipTag(text: item, color: Color.ui.originChipColor)
            : TraitChipTag(text: item, color: Color.ui.secondaryColor)
        }
        .onAppear {
            traitList.removeAll()
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
            traitList.append(countryChipText)
            
            if breed.isExperimental {
                traitList.append("Experimental")
            }
            if breed.isHairless {
                traitList.append("Hairless")
            }
            if breed.isNatural {
                traitList.append("Natural")
            }
            if breed.isRare {
                traitList.append("Rare")
            }
            if breed.isRex {
                traitList.append("Rex")
            }
            if breed.hasSuppressedTail {
                traitList.append("Suppressed tail")
            }
            if breed.hasShortLegs {
                traitList.append("Short legs")
            }
            if breed.isHypoallergenic {
                traitList.append("Hypoallergenic")
            }
        }
    }
}

struct FlexibleView<Data: Collection, Content: View>: View
where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State private var elementsSize: [Data.Element: CGSize] = [:]
    @State private var availableWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            
            VStack(alignment: alignment, spacing: spacing) {
                ForEach(computeRows(), id: \.self) { rowElements in
                    HStack(spacing: spacing) {
                        ForEach(rowElements, id: \.self) { element in
                            content(element)
                                .fixedSize()
                                .readSize { size in
                                    elementsSize[element] = size
                                }
                        }
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            } else {
                // Start a new row
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }

            remainingWidth = remainingWidth - (elementSize.width + spacing)
        }

        return rows
    }
}

struct BreedListItem_Previews: PreviewProvider {
    static var previews: some View {
        BreedListItem(breed: CatBreed.test)
            .previewLayout(.sizeThatFits)
    }
}
