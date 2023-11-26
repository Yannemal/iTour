//
//  ContentView.swift
//  iTour app
//  SwiftData by Example book > PAul Hudson
//  https://twostraws.gumroad.com/l/swiftdata-by-example/blackfriday23
//  Student yannemal on 26/11/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    //Data:
    @Environment(\.modelContext) var modelContext
    @Query var destinations: [Destination]
    
    @State private var path = [Destination]()
    
    var body: some View {
    // someView
        
        NavigationStack(path: $path) {
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
            }
            .navigationTitle("iTour")
            // set destination for detail view of each Row
            .navigationDestination(for: Destination.self, destination: EditDestinationView.init)
            .toolbar {
                Button("Add Destination", systemImage: "plus", action: addDestination)
                // Button("addSamples", action: addSamples)
                
            }
        } // end NavStack
        
    }
    // METHODS:
    
    func addDestination() {
        let destination = Destination()
        // creates a default Destination class instance
        modelContext.insert(destination)
        // adds it to SwiftData
        path = [destination]
        // sets the @State array to this destination created, triggers refresh NavStackList's NavDestination(for: .modifier to go to EditDestinationView.init 
    }
    
    func deleteDestinations(_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    
    func addSamples() {
        let bataan = Destination(name: "Bataan")
        let batangas = Destination(name: "Batangas")
        let iloilo = Destination(name: "Iloilo")
        let davao = Destination(name: "Davao")
        
        let samplesToAdd: [Destination] = [bataan, batangas, iloilo, davao]
        
        samplesToAdd.forEach { place in
            modelContext.insert(place)
        }
    }
    
}

#Preview {
    ContentView()
}
