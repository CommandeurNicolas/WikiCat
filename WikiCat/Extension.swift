//
//  Extension.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 10/03/2023.
//

import Foundation
import SwiftUI

extension Color {
    static let ui = Color.UI()
        
    struct UI {
        let transparent = Color("transparentColor")
        // MARK: Main UI colors
        let backgroundColor = Color("backgroundColor")
        let neutralColor = Color("neutralColor")
        let neutralVariantColor = Color("neutralVariantColor")
        let primaryColor = Color("primaryColor")
        let secondaryColor = Color("secondaryColor")
        let tertiaryColor = Color("tertiaryColor")
        // MARK: Origin chip color
        let originChipColor = Color("originChipColor")
    }
}

extension String {
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

extension View {
    // MARK: Used to make flexible table
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
