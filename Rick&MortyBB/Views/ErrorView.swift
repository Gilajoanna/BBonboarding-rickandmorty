//
//  ErrorView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 10/11/2023.
//

import SwiftUI

struct ErrorView: View {
    
    var errorText: String
    var reloadData: () -> Void
    
    var body: some View {
        VStack {
            Text(errorText)
                .padding()
            
            Button("Try again", action: {
                reloadData()
            })
            .buttonStyle(.bordered)
        }
        .padding()
        .frame(width: 500)
    }
}

#Preview {
    ErrorView(errorText: "Something went wrong.", reloadData: {})
}
