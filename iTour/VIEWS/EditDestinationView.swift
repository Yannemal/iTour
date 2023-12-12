//
//  EditDestinationView.swift
//  iTour  - CRUD > Update
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.
//  this is the Edit View when you add or want to change a location / Sight set importance and add a picture

import PhotosUI
import SwiftUI
import SwiftData

struct EditDestinationView: View {
    //DATA:
    @Environment(\.modelContext) private var modelContext
    // private to prevent conflict w another @Environment modelContext in contentView
    @Bindable var destination: Destination
    @State private var newSightName = ""
    
    // adding pictures > dont forget import PhotosUI    
    @State private var photosItem: PhotosPickerItem?
    var hasPicture: Bool {
        if destination.image != nil {
            return true
        } else {
            return false
        }
    }
    // pre-sorting sights of the destination as a computed prop w sights in alphabetical order:
    var sortedSights: [Sight] {
        destination.sights.sorted {
            $0.name < $1.name
        }
    }
    
    var body: some View {
        //someVIEW:
        
        Form {
            // if picture exists show picture or allow upload of one           
            Section {
                if let imageData = destination.image {
                    
                    if let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 600, height: 100)
                        
                    }
                }
                
                HStack {
                    Spacer()
                    PhotosPicker(hasPicture ? "change photo" : "Attach a photo", selection: $photosItem, matching: .images)
                        .font(.subheadline)
                }
            }
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
                ForEach(sortedSights) { sight in
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
        .onChange(of: photosItem) {
            Task {
                // add chosen image to
                destination.image = try? await photosItem?.loadTransferable(type: Data.self)
            }
        }
        
    } // end View
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
            let sight = sortedSights[index]
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
