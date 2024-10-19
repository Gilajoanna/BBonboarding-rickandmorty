//
//  EpisodeDetailView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 12/10/2023.
//

import SwiftUI
import ApiClient

struct EpisodeDetailView: View {
    
    let episode: Episode
    
    var body: some View {
        VStack {
            Divider()
            Group {
                DetailsItemView(title: "Title", subTitle: episode.name)
                DetailsItemView(title: "Air date", subTitle: episode.airDate)
            }
            .padding(.horizontal, 15)
            Divider()
            
            Group {
                Text("CHARACTER APPEARANCE")
                    .font(.system(size: 12))
                DetailsCharacterListView(singleCharacterURLs: episode.characters)
            }
        }
        .navigationTitle("\(episode.season) - Episode \(episode.prettyEpisodeText)")
        .frame(maxWidth: .infinity)
        .foregroundColor(.diamondWhite)
        .background(Color.petrol)
    }
}

#Preview {
    EpisodeDetailView(episode: Episode.mock)
}
