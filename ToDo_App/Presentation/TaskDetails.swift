//
//  TaskDetails.swift
//  ToDo_App
//
//  Created by Luis Quintero on 09/07/25.
//

import SwiftUI
import SwiftData

struct TaskDetails: View {
    
    @Environment(\.modelContext) private var context
    
    // Close view and go to the presenter (TasksView)
    @Environment(\.dismiss) private var dissmiss
    
    @Bindable var task: TaskModel
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                TextEditor(text: $task.taskDescription)
            }
            .padding(16)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Ready") {
                    try? context.save()
                    hideKeyBoard()
                }
            }
        }
    }
}

#Preview {
    let mockTask = TaskModel(title: "Mock from mockNotesContainer", taskDescription: "")
    
    TaskDetails(task: mockTask)
        .modelContainer(mockNotesContainer())
}

