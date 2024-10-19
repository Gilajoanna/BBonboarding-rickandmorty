//
//  ArrowIconView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 07/11/2023.
//

import SwiftUI

struct ArrowIconView: View {
    var body: some View {
        Image(systemName: "chevron.right")
            .foregroundColor(.lime)
            .fontWeight(.bold)
            .font(.subheadline)
    }
}

#Preview {
    ArrowIconView()
}
