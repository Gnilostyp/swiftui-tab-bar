//
//  KeyboardObserver.swift
//
//
//  Created by Zijie on 21.05.2023.
//  Copyright © 2023 Zijie. All rights reserved.
//
//  ====================================================================================================================
//

import SwiftUI

class KeyboardObserver: ObservableObject {
    static let shared: KeyboardObserver = .init()

    @Published private(set) var keyboardWillShow = false

    private init() {
        NotificationCenter.default
            .addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { _ in
                Task {
                    await MainActor.run { self.keyboardWillShow = true }
                }
            }

        NotificationCenter.default
            .addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                Task {
                    await MainActor.run { self.keyboardWillShow = false }
                }
            }
    }
}
