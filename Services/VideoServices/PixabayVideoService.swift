//
//  PixabayVideoService.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//


import Foundation
import Combine

protocol VideoServiceProtocol {
    func fetchVideos(query: String?, page: Int, perPage: Int) -> AnyPublisher<PixabayVideoResponse, Error>
    func fetchRelatedVideos(tags: String, page: Int, perPage: Int) -> AnyPublisher<PixabayVideoResponse, Error>
}

struct PixabayVideoService: VideoServiceProtocol {
    
    static let shared = PixabayVideoService()
    
    func fetchVideos(query: String? = nil, page: Int = 1, perPage: Int = 20) -> AnyPublisher<PixabayVideoResponse, Error> {
        var components = URLComponents(url: PixabayAPIConfig.baseURL, resolvingAgainstBaseURL: false)!
        var items = [
            URLQueryItem(name: "key", value: PixabayAPIConfig.apiKey),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "per_page", value: String(perPage))
        ]
        if let q = query, !q.isEmpty {
            items.append(URLQueryItem(name: "q", value: q))
        }
        components.queryItems = items
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: PixabayVideoResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchRelatedVideos(tags: String, page: Int = 1, perPage: Int = 10) -> AnyPublisher<PixabayVideoResponse, Error> {
        let query = tags
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .prefix(3)
            .joined(separator: " ")
        
        return fetchVideos(query: query, page: page, perPage: perPage)
    }
}
