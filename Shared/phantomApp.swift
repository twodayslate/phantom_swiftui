//
//  phantomApp.swift
//  Shared
//
//  Created by Zachary Gorak on 7/29/21.
//

import SwiftUI

@main
struct phantomApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
