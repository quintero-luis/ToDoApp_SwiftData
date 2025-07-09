//
//  MockNotes.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import SwiftData

@MainActor // .mainContext is a property that is isolated from the @MainActor
func mockNotesContainer() -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    
    let container = try! ModelContainer(for: TaskModel.self, configurations: config)
    
    let context = container.mainContext
    
    return container
}
