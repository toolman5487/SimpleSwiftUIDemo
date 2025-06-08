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

    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: animationName)
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
       
    }
}
