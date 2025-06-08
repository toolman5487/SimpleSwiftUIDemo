//
//  MakeAnimationView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/8.
//

import Foundation
import SwiftUI
import Lottie

struct MakeAnimationView: UIViewRepresentable {
    var animationName: String = "ArticleAnimation"
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.play()
        container.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: container.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let animationView = uiView.subviews.first as? LottieAnimationView {
            animationView.animation = LottieAnimation.named(animationName)
            animationView.play()
        }
    }
}
