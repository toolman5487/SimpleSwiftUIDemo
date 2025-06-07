//
//  LottieRefresh.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI
import Lottie

struct RefreshAnimationView: UIViewRepresentable {
   
    var animationName: String = "RefreshAnimation"
    var loopMode: LottieLoopMode = .loop

    func makeUIView(context: Context) -> some UIView {
        let animationView = LottieAnimationView(name: " RefreshAnimation")
        animationView.loopMode = loopMode
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        return animationView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
      
    }
}
