//
//  UINavigationBar.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 02/10/2023.
//

import SwiftUI
import UIKit

struct UINavigationBarLayout {
    
    static func setAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color(.colorPetrol).opacity(0.95))
        appearance.titleTextAttributes = [ .foregroundColor: UIColor(named: "ColorDiamondWhite")! ]
        appearance.largeTitleTextAttributes = [ .foregroundColor: UIColor(named: "ColorDiamondWhite")! ]
    
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
}
