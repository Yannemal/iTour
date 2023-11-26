//
//  EditDestinationView.swift
//  iTour  - CRUD > Update
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.


import SwiftUI
import SwiftData

struct EditDestinationView: View {
    //DATA:
    @Bindable var destination: Destination
    
    var body: some View {
        //someVIEW:
        
        Form {
            // Textfields to edit text for destination name and details
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            // a date picker to adjust date and time of visit
            DatePicker("Date", selection: $destination.date)
            // a picker to adjust priority
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("Maybe").tag(2)
                    Text("Must-see").tag(3)
                }
                .pickerStyle(.segmented)
            }
        } // end form
        .navigationTitle("Edit Destination")
        
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        
        let example = Destination(name: "Example Destination", details: "Example details go here and will expand vertical as they are edited", date: .now, priority: 2)
        
        return EditDestinationView(destination: example)
            .modelContainer(container)
    } catch {
        fatalError("failed to create model container")
    }
}
