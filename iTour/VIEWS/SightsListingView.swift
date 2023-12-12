//
//  SightsListingView.swift
//  iTour
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 12/12/2023.
//

import SwiftUI
import SwiftData

struct SightsListingView: View {
    //DATA:
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Sight.name)])
    var sights: [Sight]
    
    var body: some View {
        //someVIEW:
        
        List {
            ForEach(sights) { sight in
                NavigationLink(value: sight.destination) {
                    Text(sight.name)
                }
            }
            .onDelete(perform: deleteSight)
        } //end List
    }
    //METHODS:
    init(searchString: String) {
        _sights = Query(filter: #Predicate {
            if searchString.isEmpty {
                return $0.name > ""
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
        })
    }
    
    func deleteSight(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sights[index]
            modelContext.delete(sight)
        }
    }
    
}

//#Preview {
//    SightsListingView()
//}
