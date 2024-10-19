//
//  EpisodeViewModel.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 09/11/2023.
//

import Foundation
import Dependencies
import ApiClient

class EpisodeViewModel: ObservableObject {
    
    @Dependency(\.apiClient) var apiClient
    
    @Published var episodes: Episodes?
    @Published var episodeList: [Episode] = []
    
    func getEpisodes() {
        Task {
            do {
                let episodes = try await apiClient.getEpisodes()
                DispatchQueue.main.async {
                    self.episodes = episodes
                    self.episodeList.removeAll()
                    self.episodeList.append(contentsOf: episodes.results)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
