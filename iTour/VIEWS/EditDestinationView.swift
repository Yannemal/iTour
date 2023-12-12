//
//  EditDestinationView.swift
//  iTour  - CRUD > Update
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.
//  this is the Edit View when you add or want to change a location

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    //DATA:
    @Environment(\.modelContext) private var modelContext
    // private to prevent conflict w another @Environment modelContext in contentView
    @Bindable var destination: Destination
  
    @State private var newSightName = ""
    
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
            // add new section for Sights
            Section("Sights") {
                ForEach(destination.sights) { sight in
                    Text(sight.name)
                } // end forEach Section > a Section is a diff kind of List ?
                .onDelete(perform: deleteSights)
                
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    
                    Button("Add", action: addSight)
                }
            }
        } // end form
        .navigationTitle("Edit Destination")
        
        .navigationBarTitleDisplayMode(.inline)
    }
    // Methods:
    // CRUD - Create
    func addSight() {
        guard newSightName.isEmpty == false  else {
            // set warning pop up or suggestions here
            return 
            
        }
        // if you get by the guard then do this:
        withAnimation {
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
            // after adding sight to destination reset newSightName to an empty String
        }
    }
  
    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = destination.sights[index]
            modelContext.delete(sight)
        }
        // ⬇️ only necessary when inverse relationships have not been added yet:
        // destination.sights.remove(atOffsets: indexSet)
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
