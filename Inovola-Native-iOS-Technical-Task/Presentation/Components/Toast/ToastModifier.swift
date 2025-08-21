//
//  ToastModifier.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    let type: ToastType

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    ToastMessage(message: message, type: type)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(1)
                    Spacer()
                }
                .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
}
