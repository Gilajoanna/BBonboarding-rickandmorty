//
//  LocationListItemView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 07/11/2023.
//

import SwiftUI
import ApiClient

struct LocationListItemView: View {
    
    let location: Location
    
    var body: some View {
        HStack(spacing: 15) {
            Image("origin-icon")
                .font(.system(size: 48))
                .fontWeight(.thin)
                .foregroundColor(.turquoise)

            VStack(alignment: .leading) {
                Text(location.name)
                    .fontWeight(.bold)
                Text(location.type ?? "unknown")
                    .foregroundColor(.lightBlue)
            }
            
            Spacer()
            ArrowIconView()
        } //: HSTACK
        .padding(.horizontal)
    }
}

#Preview {
    LocationListItemView(location: Location.mock)
}
