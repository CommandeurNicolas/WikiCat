//
//  ShowMoreButton.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 12/05/2023.
//

import SwiftUI

struct ShowMoreButton: View {
    @Binding var showMore: Bool
    
    var body: some View {
        Button {
            self.showMore.toggle()
        } label: {
            Image(systemName: self.showMore ? "chevron.up" : "chevron.down")
                .frame(width: 32, height: 32)
                .background(Color.ui.primaryColor)
                .foregroundColor(Color.ui.backgroundColor)
                .cornerRadius(8)
        }
    }
}

struct ShowMoreButton_Previews: PreviewProvider {
    static var previews: some View {
        ShowMoreButton(showMore: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
