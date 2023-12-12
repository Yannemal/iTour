//
//  SightsView.swift
//  iTour
//  SwiftData by Example book > Paul Hudson
//  Student yannemal on 12/12/2023.
//

import SwiftUI
import SwiftData

struct SightsView: View {
    //DATA: get me all sights and -> in an array
    @Query(sort: \Sight.name) var sights: [Sight]
    
    @State private var searchSights: String = ""
    
    var body: some View {
    // someVIEW:
        NavigationStack{
            SightsListingView(searchString: searchSights)
            .navigationTitle("Sights")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchSights)
            
            
        } // endStack

    }
    //METHODS:
    
}

#Preview {
    SightsView()
}
