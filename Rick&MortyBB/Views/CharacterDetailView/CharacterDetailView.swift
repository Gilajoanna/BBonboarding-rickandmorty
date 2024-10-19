//
//  CharacterDetailView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 08/09/2023.
//

import SwiftUI
import ApiClient

struct CharacterDetailView: View {
    
    let character: Character
    
    var body: some View {
        ZStack {
            ScrollView {
                    VStack {
                        AsyncImage(
                            url: URL(string: character.image),
                            content: { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        
                        CharacterDetailListView(character: character)
                            .padding(.vertical, 20)
                    }
                }
            }
            .navigationTitle(character.name)
            .frame( maxWidth: .infinity)
            .foregroundColor(.diamondWhite)
            .background(Color.petrol)
    }
}

 struct CharacterDetailView_Previews: PreviewProvider {
 static var previews: some View {
     CharacterDetailView(character: Character.mock)
     }
 }
