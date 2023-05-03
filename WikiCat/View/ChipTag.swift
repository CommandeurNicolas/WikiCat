//
//  ChipTag.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/03/2023.
//

import SwiftUI

struct TraitChipTag: View {
    let text: String
    let color: Color
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(text)
            .foregroundColor(colorScheme == .dark ? .white : Color.ui.neutralColor)
            .font(.custom("Asap-Regular", size: 8))
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(
                ZStack {
                    Capsule()
                        .fill(color.opacity(0.2))
                    Capsule()
                        .stroke(color)
                }
            )
    }
}

struct ChipTag: View {
    let text: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Text(text)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .font(.system(size: 16))
//            .frame(height: 32)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(colorScheme == .dark ? .red.opacity(0.5) : .red.opacity(0.3))
                }
            )
    }
}

struct ChipTag_Previews: PreviewProvider {
    static var previews: some View {
        ChipTag(text: "Hello World !")
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Chip tag")
        TraitChipTag(text: "Hello world", color: Color.ui.originChipColor)
            .previewLayout(.sizeThatFits)
            .padding()
            .previewDisplayName("Trait Chip tag")
    }
}
