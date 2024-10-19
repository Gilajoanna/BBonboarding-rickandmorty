//
//  NavigationBarTitleView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 24/10/2023.
//

import SwiftUI

struct NavigationBarTitleView: View {
    @Binding var selectedSeason: String

    var body: some View {
        GeometryReader { geometry in
            VStack {
                if geometry.frame(in: .global).minY < 0 {
                    Text("Episodes")
                        .font(.largeTitle)
                        .foregroundColor(.diamondWhite)
                } else {
                    Text("Episodes")
                        .font(.title)
                        .foregroundColor(.diamondWhite)
                }
            }
        }
    }
}
