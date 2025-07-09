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
    
    @Bindable var task: TaskModel
    
    
    var body: some View {
        TextField("Task:", text: $task.title)
        
        Button("Guardar cambios") {
                        try? context.save()
                    }
                    .foregroundColor(.blue)
    }
}

#Preview {
   
}
