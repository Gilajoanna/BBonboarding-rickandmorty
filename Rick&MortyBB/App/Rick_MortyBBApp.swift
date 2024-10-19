//
//  Rick_MortyBBApp.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 30/08/2023.
//

import SwiftUI

@main
struct Rick_MortyBBApp: App {
    
    @StateObject private var characterVm = CharacterViewModel()

    var body: some Scene {
        WindowGroup {
            if characterVm.isLoading {
                LaunchScreenView()
                    .onAppear {
                        characterVm.getCharacters()
                    }
            } else {
                TabBarView()
            }
        }
    }
}
