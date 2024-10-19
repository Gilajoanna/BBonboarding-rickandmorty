//
//  CharacterListItemView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 06/09/2023.
//

import SwiftUI
import ApiClient

struct CharacterListItemView: View {
    
    let character: Character
    
    var body: some View {
            HStack(spacing: 15) {
                AsyncImage(
                    url: URL(string: character.image),
                    content: { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxWidth: 64, maxHeight: 64)
                             .cornerRadius(8)
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
                .padding(.leading, 20)
                VStack(alignment: .leading) {
                    Text(character.name)
                        .fontWeight(.bold)
                    Text(character.species)
                        .foregroundColor(.lightBlue)
                }
                
                Spacer()
                ArrowIconView()
                    .padding()
            } //: HSTACK
    }
}

 struct CharacterListItemView_Previews: PreviewProvider {
     static var previews: some View {
         CharacterListItemView(character: Character.mock)
     }
 }
