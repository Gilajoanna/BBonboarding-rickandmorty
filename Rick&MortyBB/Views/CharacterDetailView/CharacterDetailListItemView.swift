//
//  CharacterDetailListItemView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 15/09/2023.
//

import SwiftUI

struct CharacterDetailListItemView: View {
    
    var icon: String
    var title: String
    var subTitle: String
    
    var body: some View {
        HStack {
            Image(icon)
            Text(title)
                .fontWeight(.bold)
                .padding(.leading, 15)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(subTitle)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    CharacterDetailListItemView(icon: "alive-icon", title: "title", subTitle: "subtitle")
}
