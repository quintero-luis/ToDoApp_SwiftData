//
//  ContentView.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    // Context to add, modify and delete data - From SwiftUI but used with SwiftData to obtain access to the context
    @Environment(\.modelContext) private var context
    // Fetch all instances of TaskModel
    //To automatically consultar/query persistent data from your model (TaskModel)
    @Query private var tasks: [TaskModel]
    
    @State private var newTask = ""
    @State private var selectedTask: TaskModel?
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add new task: ", text: $newTask)
                        .padding(.horizontal,16)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4))
                        )
                    
                    Button("Add") {
                        guard !newTask.isEmpty else { return }
                        let task = TaskModel(title: newTask)
                        context.insert(task)
                        // Empty TextField after Add button tapped
                        newTask = ""
                    }
                    .padding(.horizontal, 12)
                    .frame(width: 84, height: 40)
                    .background(Color.black)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                    
                }
                .padding(16)
                
                List {
                    
                }
            }
        }// NavigationView
    }
}

#Preview {
    TasksView()
    // Pass mock data to preview
        .modelContainer(mockNotesContainer())
}
