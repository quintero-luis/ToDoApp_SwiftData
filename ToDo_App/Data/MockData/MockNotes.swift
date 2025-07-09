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
    
    let mockTasksNotes = [
        TaskModel(title: "Make app fixes"),
        TaskModel(title: "Conference 8:00 am", isDone: true),
        TaskModel(title: "Gym - Leg day"),
        TaskModel(title: "Sleep before 10:40 pm", isDone: true)
    ]
    
    // if we used Task {} instead of @MainActor, we couldn´t use the context here.
    for mockTasksNote in mockTasksNotes {
        context.insert(mockTasksNote)
    }
    
    return container
}
