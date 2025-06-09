//
//  ContentView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            ArticlesHomeView()
                .tabItem {
                    Image(systemName: "doc.text")
                        .imageScale(.large)
                }
            PhotosView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
            VideoHomeView()
                .tabItem {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
        }
    }
}

#Preview {
    AppTabView()
}
