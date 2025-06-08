//
//  CommentViewModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation
import Combine

@MainActor
class CommentViewModel: ObservableObject {
    
    @Published var comments: [Comment] = []
    @Published var errorMessage: String?
    
    private let postId: Int
    private var cancellables = Set<AnyCancellable>()
    private let commentService: CommentServiceProtocol
    
    init(postId: Int,
         commentService: CommentServiceProtocol = CommentService()) {
        self.postId = postId
        self.commentService = commentService
    }
    
    func fetchComment() {
        commentService.fetchCommentsPublisher(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] comments in
                self?.comments = comments
            }
            .store(in: &cancellables)
    }
}
