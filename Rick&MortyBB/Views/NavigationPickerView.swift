//
//  NavigationPickerView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 26/10/2023.
//

import SwiftUI
import ApiClient

struct NavigationPickerView: View {
    
    @Binding var selectedSeason: String
    var episodeList: [Episode] = []
    
    var body: some View {
        Picker("", selection: $selectedSeason) {
            let sortedList = Array(Set(episodeList.map { $0.season })).sorted()
            ForEach(sortedList, id: \.self) { season in
                Text(season.formatSeason).tag(season)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.lightBlue)
        .frame(width: 361)
        .cornerRadius(7)
        .opacity(0.8)
    }
}

#Preview {
    NavigationPickerView(selectedSeason: .constant("S0102"))
}
