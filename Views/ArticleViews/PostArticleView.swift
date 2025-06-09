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
    @State private var showPostSuccess = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                Group {
                    Text("標題")
                    TextField("請輸入標題", text: $postVM.title)
                        .textFieldStyle(.roundedBorder)
                }
                .padding(.horizontal)
                
                Group {
                    Text("文章內容")
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $postVM.body)
                            .frame(height: 180)
                            .background(Color(UIColor.systemBackground))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.3)))
                        if postVM.body.isEmpty {
                            Text("請輸入內容…")
                                .foregroundColor(Color(UIColor.tertiaryLabel))
                                .padding(.top, 8)
                                .padding(.leading, 5)
                        }
                    }
                }
                .padding(.horizontal)
                
                HStack {
                    Text("用戶 ID：")
                    Spacer()
                    Stepper(value: $postVM.userId, in: 1...10) {
                        Text("\(postVM.userId)")
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
            
                }
                .padding(.horizontal)
                
                Button {
                    postVM.addPost()
                } label: {
                    Text("送出")
                        .frame(maxWidth: .infinity)
                        .frame(height: 32)
                        .background(Color(UIColor.label))
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(16)
                }
                .padding(.horizontal)
                .disabled(postVM.title.isEmpty || postVM.body.isEmpty)
                .background(Color(UIColor.systemBackground))
                Spacer()
                HStack {
                    if postVM.createdPost == nil {
                        MakeAnimationView(animationName: "ArticleAnimation")
                            .frame(maxWidth: .infinity)
                    } else {
                        MakeAnimationView(animationName: "SendAnimation", loopMode: .playOnce)
                            .frame(maxWidth: .infinity)
                    }
                  
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("新增文章")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
            .onChange(of: postVM.createdPost) { createdPost in
                if createdPost != nil {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    PostArticleView()
}
