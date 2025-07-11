//
//  KeyboardObserver.swift
//  ToDo_App
//
//  Created by Luis Quintero on 10/07/25.
//

import SwiftUI
import Combine

final class KeyboardObserver: ObservableObject {
    // Propery that publishes itself everytime it changes
    @Published var isKeyboardVisible: Bool = false
    
    private var cancellables: Set<AnyCancellable> = [] // To save/store the subscription
    
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { _ in self.isKeyboardVisible = true }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { _ in self.isKeyboardVisible = false }
            .store(in: &cancellables)
    }
}
