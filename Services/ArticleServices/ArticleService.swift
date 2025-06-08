//
//  ArticleService.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation
import Combine

class ArticleService {
    
    func fetchArticles(start: Int? = nil, limit: Int? = nil, completion: @escaping ([Article]?, Error?) -> Void) {
        var urlString = "\(APIConfig.baseURL)/posts"
        guard let url = URL(string: urlString) else {
            completion(nil, URLError(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching articles:", error)
                completion(nil, error)
                return
            }
            
            if let data = data {
                if let articles = try? JSONDecoder().decode([Article].self, from: data) {
                    completion(articles, nil)
                } else {
                    print("Error decoding articles")
                    completion(nil, URLError(.cannotDecodeContentData))
                }
            } else {
                print("Error: no data received")
                completion(nil, URLError(.badServerResponse))
            }
        }.resume()
    }
    
    
    func addPostPublisher(_ newPost: Article) -> AnyPublisher<Article, Error> {
        let urlString = "\(APIConfig.baseURL)/posts"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(newPost)
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { output in
                guard let http = output.response as? HTTPURLResponse,
                      http.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: Article.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
