//
//  LaunchScreenView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 13/11/2023.
//

import SwiftUI

struct LaunchScreenView: View {
    
    var body: some View {
        ZStack {
            Color(.colorPetrol)
                .edgesIgnoringSafeArea(.all)
                
            Image("RickAndMortyLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
        }
    }
}

#Preview {
    LaunchScreenView()
}
