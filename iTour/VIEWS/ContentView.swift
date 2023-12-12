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
    @State private var sortOrder = [SortDescriptor(\Destination.name),
                                    SortDescriptor(\Destination.date)
                                    ]
    // default sortOrder by name alphabetically, an [Array of sortdescriptor ] so we can have tie breakers (see tag picker)
    @State private var searchText = ""
    
    @State private var minimumDate = Date.distantPast
    let currentDate = Date.now
    @State var maximumDate = Date.distantFuture
    // either show past or future or all trips :
//    @State private var showingFutureTrips = false
//    @State private var showingPasttrips = false
    
    var body: some View {
    // someView
        
        NavigationStack(path: $path) {
        // LIST
            DestinationListingView(sort: sortOrder, searchString: searchText, minimumDate: minimumDate)
            .navigationTitle("iTour")
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .searchable(text: $searchText)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
                // Button("addSamples", action: addSamples)
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Name").tag([
                            SortDescriptor(\Destination.name),
                            SortDescriptor(\Destination.date)
                            ])
                        
                        Text("Priority").tag([SortDescriptor(\Destination.priority, order: .reverse),
                                              SortDescriptor(\Destination.name)
                                              ])
                        
                        Text("Date").tag([SortDescriptor(\Destination.date),
                                          SortDescriptor(\Destination.priority),
                                          SortDescriptor(\Destination.name)
                                          ])
                    }
                    .pickerStyle(.inline)

                    Picker("Filter", selection: $minimumDate) {
                        Text("Show all destinations").tag(Date.distantPast) 
                        Text("Show upcoming destinations").tag(currentDate)

                    }
                     .pickerStyle(.inline)
                    
                    Picker("Filter", selection: $maximumDate) {
                         Text("Show only travels past").tag(currentDate)
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
