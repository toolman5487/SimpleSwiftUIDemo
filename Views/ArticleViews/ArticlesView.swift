//
//  ArticlesView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI
import Combine

struct ArticlesView: View {
    
    @State private var searchText = ""
    @StateObject private var articleVM = ArticleViewModel()
    
    var body: some View {
        NavigationView {
            List(articleVM.articles){ article in
                ArticleRow(article: article)
            }
            .navigationTitle("JSON 文章")
            .searchable(text: $searchText, prompt: "搜尋文章")
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
                    
                    HStack {
                        Text(article.body)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.secondary)
                    }
                }
        }
    }
}


#Preview {
    ArticlesView()
}
