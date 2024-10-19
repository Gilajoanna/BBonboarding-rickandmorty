//
//  EpisodeListItemView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 12/10/2023.
//

import SwiftUI
import ApiClient

struct EpisodeListItemView: View {
    
    let episode: Episode
    
    var body: some View {
            HStack(spacing: 15) {
                Text("\(episode.prettyEpisodeText)")
                    .font(.system(size: 48))
                    .fontWeight(.thin)
                    .foregroundColor(.turquoise)

                VStack(alignment: .leading) {
                    Text(episode.name)
                        .fontWeight(.bold)
                    Text(episode.airDate)
                        .foregroundColor(.lightBlue)
                }
                
                Spacer()
                ArrowIconView()
            } //: HSTACK
            .padding(.horizontal)
    }
}

#Preview {
    EpisodeListItemView(episode: Episode.mock)
}
