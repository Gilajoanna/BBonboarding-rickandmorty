//
//  RickAndMortyViewModel.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 04/09/2023.
//

import Foundation
import Dependencies
import ApiClient
import SwiftUI

class CharacterViewModel: ObservableObject {
    
    @Dependency(\.apiClient) var apiClient
    
    @Published var characters: Characters?
    @Published var character: Character?
    @Published var characterList: [Character] = []
    
    @Published var isLoading = true
    
    func getCharacters() {
        Task {
            do {
                let characters = try await apiClient.getCharacters()
                DispatchQueue.main.async {
                    self.characters = characters
                    self.characterList.removeAll()
                    self.characterList.append(contentsOf: characters.results)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.isLoading = false
                    }
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    func getCharacter(characterURL: [String]) {
        characterURL.forEach { url in
            let id = (url as NSString).lastPathComponent
            Task {
                do {
                    let character = try await apiClient.getCharacter(id)
                    
                    if !characterList.contains(where: { $0.id == character.id }) {
                        DispatchQueue.main.async {
                            self.character = character
                            self.characterList.append(character)
                        }
                    }
                }
            }
        }
    }
    
}

