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
        NavigationStack {
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
                    ForEach(tasks) { task in
                            HStack {

                                Text(task.title)
                                    .font(.title3)
                                    .padding(4)
                                
                                Spacer()
                                
                                Button {
                                    task.isDone.toggle()
                                    try? context.save()
                                    print("Circle tapped on task: \(task.title) is now: \(task.isDone ? "Checked" : "Unchecked" )")
                                } label: {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isDone ? .green : .gray)
                                        .font(.system(size: 24, weight: .bold))
                                }
                                .buttonStyle(.plain) // Sets the style for buttons with a custom appearance and custom interaction behavior.
                                
                            } // HStack
                            .contentShape(Rectangle()) // Make better tappable view
                            .onTapGesture {
                                selectedTask = task
                                hideKeyBoard() // hideKeyboard
                                print("Row tapped: \(task.title)")
                            }
                        
                        
                    }
                    .onDelete { tasksSet in
                        for index in tasksSet {
                            context.delete(tasks[index])
                            print("Task: \(tasks[index].title) has been deleted")
                        }
                    }
                }
            } // VStack
            .navigationDestination(item: $selectedTask) { task in
                TaskDetails(task: task)
            }
        }// NavigationView
        
    }
}

#Preview {
    TasksView()
        .modelContainer(mockNotesContainer()) // Pass mock data to preview
}
