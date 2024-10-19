//
//  LocationListView.swift
//  Rick&MortyBB
//
//  Created by Gila Johansson on 11/09/2023.
//

import SwiftUI
import ApiClient

struct LocationListView: View {
    
    @ObservedObject var vm = LocationViewModel()
                      
    var body: some View {
        NavigationStack {
            ScrollView {
                if vm.locationList.isEmpty {
                    ErrorView(errorText: "No locations found.", reloadData: vm.getLocations)
                } else {
                    LazyVStack {
                        ForEach(vm.locationList, id: \.id) { location in
                            NavigationLink(destination: LocationDetailView(location: location)) {
                                    LocationListItemView(location: location)
                                } //: NAVIGATION LINK
                        } //: LOOP
                        .padding(.vertical, 10)
                    }//: LAZYVSTACK
                }
            } //: SCROLLVIEW
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.automatic)
            .foregroundColor(.diamondWhite)
            .background(Color.petrol)
        } //: NAVIGATION STACK
        .onAppear {
            UINavigationBarLayout.setAppearance()
            vm.getLocations()
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}

