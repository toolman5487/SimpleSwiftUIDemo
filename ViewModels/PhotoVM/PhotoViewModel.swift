//
//  PhotoViewModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation
import SwiftUI

@MainActor
class PhotosViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var errorMessage: String?
    @Published var isLoading = false

    private let service = PhotoService()
    
    func fetchPhotos() {
        isLoading = true
        Task {
            defer { isLoading = false }
            do {
                photos = try await service.fetchPhotos()
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}

