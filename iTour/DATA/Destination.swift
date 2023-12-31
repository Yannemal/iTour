//
//  Destination.swift
//  iTour
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    // relationships:
    @Relationship(deleteRule: .cascade)
    var sights = [Sight]()
    
    init(
        // defaults set up
        name: String = "",
        details: String = "",
        date: Date  = .now,
        priority: Int = 2
    ) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
    }
}
