//
//  ContentView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 30/08/2023.
//

import SwiftUI
import UIKit
import ApiClient

struct CharacterListView: View {
    
    @ObservedObject var vm = CharacterViewModel()
    @State private var searchText = ""
                      
    var body: some View {
        NavigationStack {
            ScrollView {
                if searchResults.isEmpty {
                    ErrorView(errorText: "No characters found.", reloadData: vm.getCharacters)
                } else {
                    LazyVStack {
                            ForEach(searchResults, id: \.id) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    CharacterListItemView(character: character)
                                }
                            } //: LOOP
                            .padding(.vertical, 10)
                    } //: LAZYVSTACK
                }
            } //: SCROLLVIEW
            .navigationTitle("Characters")
            .navigationBarTitleDisplayMode(.automatic)
            .foregroundColor(.diamondWhite)
            .background(Color.petrol)
        } //: NAVIGATION STACK
        .searchable(text: $searchText)
        .onAppear {
            UINavigationBarLayout.setAppearance()
            vm.getCharacters()
        }
    }
    
    var searchResults: [Character] {
        if searchText.isEmpty {
            return vm.characterList
        } else {
            return vm.characterList.filter {
                $0.name.contains(searchText)
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
