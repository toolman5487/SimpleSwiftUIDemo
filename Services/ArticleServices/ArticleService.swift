//
//  ArticleService.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation

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
}
