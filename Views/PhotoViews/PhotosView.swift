//
//  PhotosView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI

struct PhotosView: View {
    
    @StateObject private var vm = PhotosViewModel()
    @State private var searchText = ""
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    private var filteredPhotos: [Photo] {
        if searchText.isEmpty {
            return vm.photos
        } else {
            return vm.photos.filter { photo in
                photo.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if vm.isLoading {
                    ProgressView()
                } else if let message = vm.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(filteredPhotos) { photo in
                                AsyncImage(url: URL(string: photo.thumbnailUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    case .failure(let error):
                                        VStack {
                                            Image(systemName: "exclamationmark.triangle")
                                                .foregroundColor(.red)
                                            Text(error.localizedDescription)
                                                .font(.caption)
                                                .foregroundColor(.red)
                                        }
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width / 3 - 2, height: UIScreen.main.bounds.width / 3 - 2)
                                .clipped()
                            }
                        }
                        .padding(2)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "搜尋照片標題")
        }
        .task {
            vm.fetchPhotos()
        }
    }
}

#Preview {
    PhotosView()
}
