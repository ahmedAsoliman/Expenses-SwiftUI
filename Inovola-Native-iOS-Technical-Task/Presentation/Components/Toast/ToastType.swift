//
//  ToastType.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//
import SwiftUI

enum ToastType {
    case success
    case error

    var backgroundColor: Color {
        switch self {
        case .success: return .green
        case .error:   return .red
        }
    }

    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error:   return "xmark.octagon.fill"
        }
    }
}
