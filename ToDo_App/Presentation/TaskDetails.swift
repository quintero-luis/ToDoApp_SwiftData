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

//                TextField("Task:", text: $task.title)
//                    .padding(.horizontal, 16)
//                    .padding(.vertical, 16)
//                    .background(Color(.systemGray6))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.gray.opacity(0.4))
//                    }

//                Button("Guardar cambios") {
//                    try? context.save()
//                        dissmiss()
//                }
//                .padding(.horizontal, 12)
//                .padding(.vertical, 8)
//                .background(Color.white)
//                .foregroundColor(.black)
//                .cornerRadius(12)
//                .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
//                .font(.system(size: 24, weight: .regular))
