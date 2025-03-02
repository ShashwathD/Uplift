//
//  UpliftApp.swift
//  Uplift
//
//  Created by Shashwath Dinesh on 3/1/25.
//

import SwiftUI

@main
struct UpliftApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
