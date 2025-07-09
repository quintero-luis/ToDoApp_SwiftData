//
//  View+Extensions.swift
//  ToDo_App
//
//  Created by Luis Quintero on 08/07/25.
//

import SwiftUI

extension View {
    // Used to hide keyboard when any other side of the view is tapped
    func hideKeyBoard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
