//
//   CommentService.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation
import Combine

protocol CommentServiceProtocol {
    func fetchCommentsPublisher(postId: Int) -> AnyPublisher<[Comment], Error>
}

struct CommentService: CommentServiceProtocol {
    private let baseURL = APIConfig.baseURL

    func fetchCommentsPublisher(postId: Int) -> AnyPublisher<[Comment], Error> {
        let urlString = "\(baseURL)/comments?postId=\(postId)"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
