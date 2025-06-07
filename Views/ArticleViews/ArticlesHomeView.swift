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
    
    var body: some View {
        NavigationView {
            List(articleVM.filteredArticles){ article in
                ArticleRow(article: article)
            }
            .navigationTitle("JSON 文章")
            .searchable(text: $articleVM.searchText, prompt: "搜尋文章")
            .task {
                articleVM.fetchArticles()
            }
        }
    }
    
    struct ArticleRow: View {
        let article: Article
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(article.body)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(3)
                }
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
        }
    }
}


#Preview {
    ArticlesHomeView()
}
