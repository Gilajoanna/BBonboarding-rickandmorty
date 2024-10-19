//
//  EpisodeCharacterAppearance.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 12/10/2023.
//

import SwiftUI
import ApiClient

struct DetailsCharacterListView: View {
    
    @ObservedObject var vm = CharacterViewModel()
    
    let singleCharacterURLs: [String]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(vm.characterList, id: \.id) { character in
                        NavigationLink(destination: CharacterDetailView(character: character)) {
                            CharacterListItemView(character: character)
                        }
                    } //: LOOP
            } //: SCROLLVIEW
            .background(Color.petrol)
        } //: NAVIGATION STACK
        .onAppear {
            vm.getCharacter(characterURL: singleCharacterURLs)
        }
    }
}

 #Preview {
     DetailsCharacterListView(singleCharacterURLs: Episode.mock.characters)
 }
 
