//
//  ViewModifier.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import Foundation
import SwiftUI

struct CapsuleButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(UIColor.systemBackground))
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(Color(UIColor.label))
            .clipShape(Capsule())
    }
}

extension View {
    func capsuleButtonStyle() -> some View {
        self.modifier(CapsuleButtonStyle())
    }
}
