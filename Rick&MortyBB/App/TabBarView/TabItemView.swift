//
//  TabItemView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 11/09/2023.
//

import SwiftUI

struct TabItemView: View {
    
    @Binding var selectedTab: Int
    
    let tabItemImage: String
    let selectedTabItemImage: String
    let tabItemText: String
    let tabTag: Int
    
    var body: some View {
        VStack {
            Image(selectedTab == tabTag ? selectedTabItemImage : tabItemImage)
                .resizable()
                .frame(width: 24, height: 24)
            Text(tabItemText)
        }
        .onTapGesture {
            selectedTab = tabTag
        }
    }
}

 struct TabItemView_Previews: PreviewProvider {
     static var previews: some View {
         TabItemView(selectedTab: .constant(0), tabItemImage: "characters-default", selectedTabItemImage: "characters-active", tabItemText: "Characters", tabTag: 0)
     }
 }
