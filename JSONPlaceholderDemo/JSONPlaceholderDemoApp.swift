//
//  JSONPlaceholderDemoApp.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI

@main
struct JSONPlaceholderDemoApp: App {
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
