//
//  CoreData_App.swift
//  CoreData_
//
//  Created by Thibault Giraudon on 13/10/2023.
//

import SwiftUI

@main
struct CoreData_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
