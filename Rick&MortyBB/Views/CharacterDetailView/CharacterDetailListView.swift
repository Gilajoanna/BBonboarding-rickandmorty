//
//  CharacterDetailListView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 15/09/2023.
//

import SwiftUI
import ApiClient

struct CharacterDetailListView: View {
    
    let character: Character
    
    var traits: [TraitListModel] {
        return [
            TraitListModel(icon: character.statusIcon, title: "Status", info: character.status.rawValue),
            TraitListModel(icon: character.speciesIcon(for: character.species), title: "Species", info: character.species),
            TraitListModel(icon: "type-icon", title: "Type", info: character.type ?? "unknown"),
            TraitListModel(icon: character.genderIcon, title: "Gender", info: character.gender.rawValue),
            TraitListModel(icon: "origin-icon", title: "Origin", info: character.origin.name),
            TraitListModel(icon: "location-icon", title: "Location", info: character.location.name),
        ]
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(traits, id: \.title) { trait in
                CharacterDetailListItemView(icon: trait.icon, title: trait.title, subTitle: trait.info)
            }
        }
    }
}

struct CharacterDetailListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailListView(character: Character.mock)
    }
}
