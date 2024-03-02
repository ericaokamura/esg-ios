//
//  Embrace_ESGApp.swift
//  Embrace ESG
//
//  Created by Erica Okamura on 27/02/24.
//

import SwiftUI

@main
struct Embrace_ESGApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    
}
