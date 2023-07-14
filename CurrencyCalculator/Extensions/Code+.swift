//
//  Code+.swift
//  CurrencyCalculator
//
//  Created by Isaac Iniongun on 12/07/2023.
//

import Foundation
import UIKit

typealias VoidAction = (() -> Void)
typealias ArgumentAction<T> = ((T) -> Void)
typealias ResultAction<T: Codable> = ((Result<T, CustomError>) -> Void)

func _print(_ message: Any, _ messageType: ToastType = .error, isJsonResponse: Bool = false) {
    #if DEBUG
    switch messageType {
    case .error:
        print("🔴🔴🔴 " + String(describing: message))
    case .success:
        if isJsonResponse {
            print("Request Response: 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢 🟢")
            print(message)
        } else {
            print("🟢🟢🟢 " + String(describing: message))
        }
    }
    #endif
}

func generateHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
}

var notchHeight: CGFloat { UIApplication.shared.statusBarFrame.height }
