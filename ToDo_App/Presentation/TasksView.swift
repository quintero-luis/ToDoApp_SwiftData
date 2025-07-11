//
//  ContentView.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import SwiftUI
import SwiftData
import Combine
import TipKit

struct TasksView: View {
    // Context to add, modify and delete data - From SwiftUI but used with SwiftData to obtain access to the context
    @Environment(\.modelContext) private var context
    // Fetch all instances of TaskModel
    //To automatically consultar/query persistent data from your model (TaskModel)
    @Query private var tasks: [TaskModel]
    
    @State private var newTask = ""
    @State private var selectedTask: TaskModel?
    
    // Combine
    @StateObject private var keyboard = KeyboardObserver()
    
    // TipKit
    private var tipEraser = TasksViewTip()
    

    var body: some View {
        
        NavigationStack {
            ZStack {

                VStack {

                    HStack {
                        TextField("Add new task:", text: $newTask)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                        
                        Button(action: {
                            for task in tasks where task.isDone {
                                context.delete(task)
                            }
                        }) {
                            Image(systemName: "eraser")
                                .font(.system(size: 28))
                                .foregroundColor(.black)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 24)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.white)
                                )
                                
                                .shadow(radius: 4, x: 0, y: 2)
                        }
                        .padding(4)
                        
                    } // 1st HStack
                    .padding(16)
                    
                    // TODO: TipKit
                    TipView(tipEraser, arrowEdge: .top)

                    // Lista de tareas
                    List {
                        ForEach(tasks) { task in
                            HStack {
                                Text(task.title)
                                    .font(.title3)
                                    .padding(8)

                                Spacer()

                                Button {
                                    task.isDone.toggle()
                                    try? context.save()
                                } label: {
                                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(task.isDone ? .green : .gray)
                                        .font(.system(size: 24, weight: .bold))
                                }
                                .buttonStyle(.plain) // Sets the style for buttons with a custom appearance and custom interaction behavior.
                            } //HStack (cell)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // Tap on every cell - if keyboardvisible -> hide keyboard, if not -> Navigate
                                if keyboard.isKeyboardVisible {
                                    hideKeyBoard()
                                } else {
                                    selectedTask = task
                                }
                            }
                        } // ForEach
                        .onDelete { tasksSet in
                            for index in tasksSet {
                                context.delete(tasks[index])
                            }
                        }
                    } //List
                    
                } // 1st VStack
                
                // Floating Button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        
                        // Button Add task
                        Button {
                            guard !newTask.isEmpty else { return }
                            let task = TaskModel(title: newTask)
                            context.insert(task)
                            newTask = "" // Empty TextField after Add button tapped
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 32))
                                .padding()
                                .foregroundColor(.black)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 4, x: 0, y: 2)
                        }
                        .padding()
//                        .padding(.horizontal, 12)
//                        .frame(width: 84, height: 40)
//                        .background(Color.black)
//                        .foregroundColor(.white)
//                        .cornerRadius(12)
//                        .shadow(color: .gray.opacity(0.5), radius: 4, x: 0, y: 2)
                        
                        
                        
                    }
                } //VStack (Floating Button)
            } // 1st ZStack
            .navigationDestination(item: $selectedTask) { task in
                TaskDetails(task: task)
            }
        } // FIN NavigationStack
    }
}

#Preview {
    TasksView()
        .modelContainer(mockNotesContainer()) // Pass mock data to preview
}
