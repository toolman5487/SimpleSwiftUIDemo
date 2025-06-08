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
    @Published var searchText: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let service = PhotoService()
    
    var filteredPhotos: [Photo] {
        if searchText.isEmpty {
            return photos
        } else {
            return photos.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchPhotos() async {
        isLoading = true
        defer { isLoading = false }
        do {
            photos = try await service.fetchPhotos()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

