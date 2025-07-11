//
//  TasksViewTip.swift
//  ToDo_App
//
//  Created by Luis Quintero on 11/07/25.
//

import TipKit

struct TasksViewTip: Tip {
    var title: Text {
        Text("Advice")
    }
    
    var message: Text? {
        Text("Tap on Eraser Icon to erase all checked tasks")
    }
    
    var image: Image? {
        Image(systemName: "lightbulb")
    }
    
    
    
    // Actions
//    var actions: [Action] {
//            [
//                Action(
//                    id: "noShowAgain",
//                    title: "Don't show again",
//                    action: {
//                        try? Tips.disableTips(for: TasksViewTip.self)
//                    }
//                ),
//                Action(
//                    id: "ok",
//                    title: "OK"
//                )
//            ]
//        }
}
