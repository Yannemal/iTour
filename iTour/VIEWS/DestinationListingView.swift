//
//  DestinationListingView.swift
//  iTour
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.
//  This List filters on command and gets refreshed every time therefore needs its onw separate View

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    //DATA:
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse),
                  SortDescriptor(\Destination.name)
                 ])
    var destinations: [Destination]
    
    var body: some View {
    // someView:
        
        List {
            // List(destinations) works but then no swipe to delete !
            ForEach(destinations) { destination in
                // build UI for a single Row as followed:
                NavigationLink(value: destination) {
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        } // endList
    }
    // METHODS:
    init(sort: SortDescriptor<Destination>, searchString: String) {
        //        _destinations = Query(sort: [sort])
        // this custom init with _ causes a refresh of the view when a new sort: SortDescriptor is passed in
        // let now = Date.now
        _destinations = Query(filter: #Predicate {
        if searchString.isEmpty {
            return true
            // returns all Destinations
        } else {
            return $0.name.localizedStandardContains(searchString)
            // will ignore diacritic and is case insensitive
            // will filter our destinations on whats in search bar
        }
       
        //    $0.date > now
        }, sort: [sort])
    }
    
    // swipe to delete  CRUD - D
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
