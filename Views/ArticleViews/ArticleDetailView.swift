//
//  ArticleDetailView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI
import Combine

struct ArticleDetailView: View {
    
    let article: Article
    @StateObject private var commentVM: CommentViewModel
    
    init(article: Article) {
        self.article = article
        _commentVM = StateObject(wrappedValue: CommentViewModel(postId: article.id))
    }
    
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 8) {
                    Text(article.title)
                        .font(.largeTitle)
                        .bold()
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    Text("作者: \(article.userId)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(article.body)
                        .font(.body)
                }
                .padding(.vertical)
            }
            
            Section(header: Text("留言 (\(commentVM.comments.count))")
                .font(.headline)) {
                    ForEach(commentVM.comments) { comment in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(comment.name)
                                .font(.title3)
                                .bold()
                            
                            Text(comment.email)
                                .font(.body)
                                .foregroundColor(Color.secondary)
                            Text(comment.body)
                                .font(.body)
                                .foregroundColor(Color(UIColor.tertiaryLabel))
                        }
                        .padding(.vertical, 4)
                    }
                }
        }
        .listStyle(InsetGroupedListStyle())
        .task {
            commentVM.fetchComment()
        }
        .navigationTitle("文章詳情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ArticleDetailView(article: Article(id: 1,
                                       userId: 1,
                                       title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
                                       body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"))
}
