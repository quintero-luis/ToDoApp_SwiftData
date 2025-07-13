//
//  ToDo_AppTests.swift
//  ToDo_AppTests
//
//  Created by Luis Quintero on 08/07/25.
//

import Testing
@testable import ToDo_App

import SwiftData

struct ToDo_AppTests {
    
    @Suite("Task Model")
    struct Task_Model_Tests {
        
        @Test func is_Done_False_By_Default() async throws {
            let task = TaskModel(title: "Must be false by default")
            #expect(!task.isDone)
        }
        
        @Test func description_Empty_By_Default() async throws {
            let task = TaskModel(title: "Must be empty by default")
            #expect(task.taskDescription.isEmpty)
        }
    }

    @Suite("Tasks View Tests")
    struct Tasks_View_Tests {
        
        @Test func new_Task_Title_Is_Correct() async throws {
            let task = TaskModel(title: "Presentation")
            #expect(task.title == "Presentation")
        }
        
        @Test func is_Done_Changes_When_Toggle() async throws {
            let task = TaskModel(title: "Is Done Changes State") // False by default
            task.isDone.toggle() // Changes to true
            #expect(task.isDone)
            task.isDone.toggle() // Changes to false
            #expect(!task.isDone)
        }
        
        @MainActor // For context to work
        @Test func erase_Button_Only_Deletes_Completed_Tasks() async throws {
            let container = mockNotesContainer()
            let context =  container.mainContext // Is in main thread
            
            let allTasks = try context.fetch(FetchDescriptor<TaskModel>())
            
            for task in allTasks where task.isDone{
                context.delete(task)
            }
            try context.save()
            
            let remainingTasks = try context.fetch(FetchDescriptor<TaskModel>())
            
            print("Remaining tasks:", remainingTasks.map { "\($0.title): \($0.isDone)" }) // Check remaining tasks
            
            #expect(remainingTasks.count == 2) // 2 mockTasks of 4 are marked as isDone, so 2 are remaining false
            #expect(!remainingTasks.contains { $0.isDone}) // Remaining Tasks are not Done (isDone == false)
        }
    }
}
