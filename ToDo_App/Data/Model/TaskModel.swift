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
    // Used for the checkmarks
    var isDone: Bool
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}

/*
 import Foundation
 import SwiftData

 @Model
 class TaskModel: Identifiable {
 //    // id for every notes
 //    var id = UUID()
     // Note´s title
     var title: String
     // Used for the checkmarks
     var isDone: Bool
     
 //    // To initialize every task as false, so it is unchecked
 //    init(id: UUID = UUID(), title: String, isDone: Bool = false) {
 //        self.id = id
 //        self.title = title
 //        self.isDone = isDone
 //    }
 }
 */
