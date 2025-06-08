//
//  PostViewModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/8.
//

import Foundation
import Combine

@MainActor
class PostViewModel: ObservableObject {
    
    @Published var title: String = ""
    @Published var body: String = ""
    @Published var userId: Int = 1
    @Published var createdPost: Article?
    @Published var isPosting: Bool = false
    @Published var errorMessage: String?

    private let service: ArticleService
    private var cancellables = Set<AnyCancellable>()

    init(service: ArticleService = ArticleService()) {
        self.service = service
    }

    func addPost() {
        let newArticle = Article(id: 0, userId: userId, title: title, body: body)

        isPosting = true
        errorMessage = nil
        service.addPostPublisher(newArticle)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isPosting = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] article in
                self?.createdPost = article
            }
            .store(in: &cancellables)
    }
}
