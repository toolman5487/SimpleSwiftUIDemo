//
//  SettingView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("nickname") private var nickname = "Willy123"

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("帳號")) {
                    Text("使用者：\(nickname)")
                    }
                
                Section(header: Text("外觀")) {
                    Toggle("深黑模式", isOn: $isDarkMode)
                }
               
            }
            .navigationTitle("設定")
        }
    }
}
#Preview {
    SettingView()
}
