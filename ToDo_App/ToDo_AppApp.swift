//
//  ToDo_AppApp.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct ToDo_AppApp: App {
    
    // Tip
    init() {
        try? Tips.configure()
        try? Tips.resetDatastore() // Resets to 0 times seen
        
    }
    
    var body: some Scene {
        WindowGroup {
            TasksView()
            // Sets the model container in this scene for storing the provided model type (In this case TaskModel)
                .modelContainer(for: TaskModel.self)
        }
    }
}
