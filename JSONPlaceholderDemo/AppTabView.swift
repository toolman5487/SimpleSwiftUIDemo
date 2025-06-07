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
            ArticlesView()
                .tabItem {
                    Image(systemName: "doc.text")
                        .imageScale(.large)
                }
            PhotosView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                }
            VideoView()
                .tabItem {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            PostView()
                .tabItem {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                }
        }
    }
}

#Preview {
    AppTabView()
}
