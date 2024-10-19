//
//  EpisodeView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 11/09/2023.
//

import SwiftUI

struct EpisodeView: View {
    
    @ObservedObject var vm = EpisodeViewModel()
    @State private var selectedSeason = "S01"
                      
    var body: some View {
        NavigationStack {
            VStack {
                NavigationPickerView(selectedSeason: $selectedSeason, episodeList: vm.episodeList)
                
                ScrollView {
                    if vm.episodeList.isEmpty {
                        ErrorView(errorText: "No episodes found.", reloadData: vm.getEpisodes)
                    } else {
                        LazyVStack {
                            ForEach(vm.episodeList.filter { $0.season == selectedSeason }, id: \.id) { episode in
                                    NavigationLink(destination: EpisodeDetailView(episode: episode)) {
                                            EpisodeListItemView(episode: episode)
                                    } //: NAVIGATION LINK
                            } //: LOOP
                                .padding(.vertical, 10)
                        }//: LAZYVSTACK
                    }
                } //: SCROLLVIEW
            } //: VSTACK
            .navigationTitle("Episodes")
            .navigationBarTitleDisplayMode(.automatic)
            .foregroundColor(.diamondWhite)
            .background(Color.petrol)
        } //: NAVIGATION STACK
        .onAppear {
            UINavigationBarLayout.setAppearance()
            vm.getEpisodes()
        }
    }
}

struct EpisodeView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeView()
    }
}
