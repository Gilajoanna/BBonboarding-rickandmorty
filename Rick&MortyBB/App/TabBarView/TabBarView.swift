//
//  MainView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 11/09/2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                CharacterListView()
                    .tabItem {
                        TabItemView(selectedTab: $selectedTab, tabItemImage: "characters-default", selectedTabItemImage: "characters-active", tabItemText: "Characters", tabTag: 0)
                    }
                    .tag(0)
                
                LocationListView()
                    .tabItem {
                        TabItemView(selectedTab: $selectedTab, tabItemImage: "locations-default", selectedTabItemImage: "locations-active", tabItemText: "Locations", tabTag: 1)
                    }
                    .tag(1)
                
                EpisodeView()
                    .tabItem {
                        TabItemView(selectedTab: $selectedTab, tabItemImage: "episodes-default", selectedTabItemImage: "episodes-active",  tabItemText: "Episodes", tabTag: 2)
                    }
                    .tag(2)
            }
            .toolbarBackground(Color.petrol, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
