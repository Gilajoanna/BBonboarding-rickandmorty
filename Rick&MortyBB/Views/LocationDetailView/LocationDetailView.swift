//
//  LocationDetailView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 03/11/2023.
//

import SwiftUI
import ApiClient

struct LocationDetailView: View {
    
    let location: Location
    
    var body: some View {
        VStack {
            Divider()

            Group {
                DetailsItemView(title: "Type:", subTitle: location.type ?? "Unknown")
                DetailsItemView(title: "Dimension:", subTitle: location.dimension ?? "Unknown")
            }
            .padding(.horizontal, 15)
            Divider()
            
            Group {
                Text("RESIDENTS")
                    .font(.system(size: 12))
                if let residents = location.residents {
                    DetailsCharacterListView(singleCharacterURLs: residents)
                } else {
                    Text("No current residents at this location.")
                }
            }
        }
        .navigationTitle(location.name)
        .frame(maxWidth: .infinity)
        .foregroundColor(.diamondWhite)
        .background(Color.petrol)
    }
}

#Preview {
    LocationDetailView(location: Location.mock)
}
