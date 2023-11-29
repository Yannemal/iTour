//
//  ContentView.swift
//  iTour app
//  SwiftData by Example book > PAul Hudson
//  https://twostraws.gumroad.com/l/swiftdata-by-example/blackfriday23
//  Student yannemal on 26/11/2023.
// this is the main view with a List

import SwiftUI
import SwiftData

struct ContentView: View {
    //Data:
    @Environment(\.modelContext) var modelContext
   
   // var destinations: [Destination]
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    // default sortOrder by name alphabetically
    @State private var searchText = ""
    
    
    var body: some View {
    // someView
        
        NavigationStack(path: $path) {
        // LIST
            DestinationListingView(sort: sortOrder, searchString: searchText)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
                // Button("addSamples", action: addSamples)
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name").tag(SortDescriptor(\Destination.name))
                        
                        Text("Priority").tag(SortDescriptor(\Destination.priority, order: .reverse))
                        
                        Text("Date").tag(SortDescriptor(\Destination.date))
                    }
                    .pickerStyle(.inline)
                    // this prevents an extra menu thing appearing in the toolbar
                } // end Menu
                                 
            } // end Toolbar
        } // end NavStack
        
    }
    // METHODS:
    
    func addDestination() {
        let destination = Destination()
        // creates a new default Destination class instance
        modelContext.insert(destination)
        // adds it to SwiftData
        path = [destination]
        // sets the @State array to this destination created, triggers refresh NavStackList's NavDestination(for: .modifier to go to EditDestinationView.init 
    }


    
//    func addSamples() {
//        let bataan = Destination(name: "Bataan")
//        let batangas = Destination(name: "Batangas")
//        let iloilo = Destination(name: "Iloilo")
//        let davao = Destination(name: "Davao")
//        
//        let samplesToAdd: [Destination] = [bataan, batangas, iloilo, davao]
//        
//        samplesToAdd.forEach { place in
//            modelContext.insert(place)
//        }
//    }
    
}

#Preview {
    ContentView()
}
