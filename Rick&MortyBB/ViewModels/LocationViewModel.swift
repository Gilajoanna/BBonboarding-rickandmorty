//
//  LocationViewModel.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 09/11/2023.
//

import Foundation
import Dependencies
import ApiClient

class LocationViewModel: ObservableObject {
    
    @Dependency(\.apiClient) var apiClient
    
    @Published var locations: Locations?
    @Published var locationList: [Location] = []
    
    func getLocations() {
        Task {
            do {
                let locations = try await apiClient.getLocations()
                DispatchQueue.main.async {
                    self.locations = locations
                    self.locationList.removeAll()
                    self.locationList.append(contentsOf: locations.results)
                }
            } catch let error {
                print(error)
            }
        }
    }
}
