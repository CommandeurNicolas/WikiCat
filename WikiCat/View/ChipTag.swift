//
//  ChipTag.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/03/2023.
//

import SwiftUI

enum ChipTagSize {
    case small
    case large
}

struct ChipTag: View {
    let text: String
    let color: Color
    let chipSize: ChipTagSize

    @Environment(\.colorScheme) var colorScheme
    
    private var fontSize: CGFloat {
        get {
            switch chipSize {
            case .small:
                return 8.0
            case .large:
                return 16.0
            }
        }
    }
    private var paddingSize: CGFloat {
        get {
            switch chipSize {
            case .small:
                return 10.0
            case .large:
                return 16.0
            }
        }
    }

    var body: some View {
        Text(text)
            .foregroundColor(colorScheme == .dark ? .white : Color.ui.neutralColor)
            .font(.custom("Asap-Regular", size: self.fontSize))
            .padding(.horizontal, self.paddingSize)
            .padding(.vertical, self.paddingSize/2)
            .background(
                ZStack {
                    Capsule()
                        .strokeBorder(color)
                        .background(Capsule().fill(color.opacity(0.2)))
                        
                }
            )
    }
}

struct ChipTag_Previews: PreviewProvider {
    static var previews: some View {
        ChipTag(text: "Hello World !", color: Color.ui.originChipColor, chipSize: .large)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Large")
        ChipTag(text: "Hello World !", color: Color.ui.originChipColor, chipSize: .small)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Small")
    }
}
