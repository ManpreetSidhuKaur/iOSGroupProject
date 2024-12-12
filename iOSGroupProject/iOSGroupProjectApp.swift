//
//  iOSGroupProjectApp.swift
//  iOSGroupProject
//
//  Created by Sasidurka on 2024-12-12.
//

import SwiftUI

@main
struct iOSGroupProjectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
