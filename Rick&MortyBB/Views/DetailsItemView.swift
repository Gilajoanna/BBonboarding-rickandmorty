//
//  EpisodeDetailListItem.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 12/10/2023.
//

import SwiftUI

struct DetailsItemView: View {
    
    var title: String
    var subTitle: String
    
    var body: some View {
        HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
            Text(subTitle)
        }
        Divider()
    }
}

#Preview {
    DetailsItemView(title: "title", subTitle: "subtitle")
}
