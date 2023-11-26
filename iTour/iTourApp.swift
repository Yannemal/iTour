//
//  iTourApp.swift
//  iTour
//  SwiftData by Example book > PAul Hudson
//  https://twostraws.gumroad.com/l/swiftdata-by-example/blackfriday23
//  Student yannemal on 26/11/2023.
//

import SwiftUI
import SwiftData

@main
struct iTourApp: App {
    //DATA:
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
