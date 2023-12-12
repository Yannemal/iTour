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
    // After the Query has been run we can add it to:
    var destinations: [Destination]
    
    var body: some View {
    // someView:
        
        List {
            // List(destinations)
            ForEach(destinations) { destination in
                // build UI for a single Row as followed:
                NavigationLink(value: destination) {
                    // each Row is a NavLink bitton that opens a new DetailPage based on the Destination
                    VStack(alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        
                        Text(destination.date.formatted(date: .long, time: .shortened))
                        // each Row has a name and a date
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        } // endList
    }
    // METHODS:
    init(sort: [SortDescriptor<Destination>], searchString: String, minimumDate: Date) {
        //        _destinations = Query(sort: [sort])
        // this custom init with _ causes a refresh of the view when a new sort: SortDescriptor is passed in
        // let now = Date.now
        _destinations = Query(filter: #Predicate {
        if searchString.isEmpty {
            return $0.date > minimumDate
            
            // returns all Destinations greater than Date.distantPast which is all destinations
        } else {
            return $0.name.localizedStandardContains(searchString) && $0.date > minimumDate
            // will ignore diacritic and is case insensitive
            // will filter our destinations on whats in search bar AND check for date larger than min date
        }
//        }  else {
//            return $0.name.localizedStandardContains(searchString) && $0.date < maximumDate
       
        //    $0.date > now
        }, sort: sort)
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
    DestinationListingView(sort: [SortDescriptor(\Destination.name)], searchString: "", minimumDate: .distantPast)
}
