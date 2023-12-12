//
//  Sight.swift
//  iTour
//  SwiftData by Example book > PAul Hudson
//  Student yannemal on 26/11/2023.
//

import Foundation
import SwiftData

@Model
class Sight {
    var name: String
    
    //Relationship inverse
    var destination: Destination?
    
    init(name: String) {
        self.name = name
    }
    
}
