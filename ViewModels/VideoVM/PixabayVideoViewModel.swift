//
//  PixabayVideoViewModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import Foundation
import Combine

@MainActor
class PixabayVideoViewModel: ObservableObject {
    @Published var videos: [VideoHit] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let service: VideoServiceProtocol

    init(service: VideoServiceProtocol = PixabayVideoService.shared) {
        self.service = service
    }

    func fetchVideos(query: String? = nil, page: Int = 1, perPage: Int = 20) {
        isLoading = true
        errorMessage = nil

        service.fetchVideos(query: query, page: page, perPage: perPage)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                self.videos = response.hits
            }
            .store(in: &cancellables)
    }

    @Published var relatedVideos: [VideoHit] = []

    func fetchRelatedVideos(tags: String, currentVideoId: Int? = nil) {
        isLoading = true
        errorMessage = nil

        let query = tags
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .prefix(3)
            .joined(separator: " ")

        service.fetchRelatedVideos(tags: query, page: 1, perPage: 10)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { response in
                if let currentId = currentVideoId {
                    self.relatedVideos = response.hits.filter { $0.id != currentId }
                } else {
                    self.relatedVideos = response.hits
                }
            }
            .store(in: &cancellables)
    }
}
