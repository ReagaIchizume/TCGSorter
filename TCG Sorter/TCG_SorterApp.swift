//
//  TCG_SorterApp.swift
//  TCG Sorter
//
//  Created by Joseph Nash on 2/8/22.
//

import SwiftUI

@main
struct TCG_SorterApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
