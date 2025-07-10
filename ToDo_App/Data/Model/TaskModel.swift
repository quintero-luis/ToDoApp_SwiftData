//
//  TaskModel.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import Foundation
import SwiftData

@Model
class TaskModel {
    // Note´s title
    var title: String
    // Notes - Task Description
    var taskDescription: String
    // Used for the checkmarks
    var isDone: Bool
    
    
    init(title: String,taskDescription: String = "" ,isDone: Bool = false) {
        self.title = title
        self.taskDescription = taskDescription
        self.isDone = isDone
    }
}

