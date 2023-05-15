//
//  FlexibleRowView.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/05/2023.
//

import SwiftUI


struct FlexibleRowView<Data: Collection, Content: View>: View
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

struct FlexibleRowView_Previews: PreviewProvider {
    static var previews: some View {
        FlexibleRowView(
            data: [
                "1 Experimental",
                "2 Hairless",
                "3 Natural",
                "4 Rare",
                "5 Hairless",
                "6 Natural",
                "7 Rare",
            ],
            spacing: 4,
            alignment: .leading
        ) {
            item in
            ChipTag(text: item, color: Color.ui.secondaryColor, chipSize: .large)
        }
    }
}
