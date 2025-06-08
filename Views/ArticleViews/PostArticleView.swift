//
//  PostArticleView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/8.
//

import SwiftUI
import Lottie

struct PostArticleView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var postVM = PostViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("標題")) {
                        TextField("請輸入標題", text: $postVM.title)
                    }
                    Section(header: Text("內文")) {
                        TextEditor(text: $postVM.body)
                            .frame(height: 120)
                    }
                    Section(header: Text("User ID")) {
                        Stepper(value: $postVM.userId, in: 1...10) {
                            Text("\(postVM.userId)")
                        }
                    }
                    if let error = postVM.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                    Button("送出") {
                        postVM.addPost()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 32)
                    .foregroundColor(.init(uiColor: .label))
                    .cornerRadius(10)
                    .disabled(postVM.isPosting || postVM.title.isEmpty || postVM.body.isEmpty)
                }
                
                if postVM.createdPost == nil {
                   MakeAnimationView(animationName: "ArticleAnimation")
                        .frame(width: 100, height: 100, alignment: .center)
                } else {
                    MakeAnimationView(animationName: "PostAnimation")
                        .frame(width: 100, height: 100, alignment: .center)
                }
            }
            
            .navigationTitle("新增文章")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("關閉") { dismiss() }
                }
            }
        }
        .onReceive(postVM.$createdPost.compactMap { $0 }) { _ in
            dismiss()
        }
    }
}

#Preview {
    PostArticleView()
}
