//
//  ArticlesView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI
import Combine

struct ArticlesHomeView: View {
    
    @StateObject private var articleVM = ArticleViewModel()
    @State private var showPostArticle = false
    
    var body: some View {
        NavigationStack {
            List(articleVM.filteredArticles){ article in
                NavigationLink(destination: ArticleDetailView(article: article)) {
                    ArticleRow(article: article)
                }
            }
            .navigationTitle("JSON 文章")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showPostArticle = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            .sheet(isPresented: $showPostArticle) {
                PostArticleView()
                    .presentationDetents([.large])
            }
            .searchable(text: $articleVM.searchText, prompt: "搜尋文章")
            .task {
                articleVM.fetchArticles()
            }
        }
    }
    
    struct ArticleRow: View {
        let article: Article
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(article.body)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
            }
        }
    }
}


#Preview {
    ArticlesHomeView()
}
