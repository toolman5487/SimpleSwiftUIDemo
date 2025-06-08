//
//  ArticleViewModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation
import Combine

@MainActor
class ArticleViewModel: ObservableObject{
    
    @Published var articles: [Article] = []
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    private var cancellables = Set<AnyCancellable>()
    
    var filteredArticles: [Article] {
           if searchText.isEmpty {
               return articles
           } else {
               return articles.filter {
                   $0.title.localizedCaseInsensitiveContains(searchText)
               }
           }
       }

    
    func fetchArticles() {
        isLoading = true
        URLSession.shared
            .dataTaskPublisher(for: APIConfig.baseURL.appendingPathComponent("posts"))
            .map(\.data)
            .decode(type: [Article].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] articles in
                self?.articles = articles
            }
            .store(in: &cancellables)
    }
}
