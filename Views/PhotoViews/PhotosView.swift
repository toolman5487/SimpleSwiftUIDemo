//
//  PhotosView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI


struct PhotosView: View {
    
    @StateObject private var phtoVM = PhotosViewModel()
    @State private var searchText = ""
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    private var filteredPhotos: [Photo] {
        if searchText.isEmpty {
            return phtoVM.photos
        } else {
            return phtoVM.photos.filter { photo in
                photo.title.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Group {
                if phtoVM.isLoading {
                    ProgressView()
                } else if let message = phtoVM.errorMessage {
                    Text(message)
                        .foregroundColor(.red)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 2) {
                            ForEach(phtoVM.filteredPhotos) { photo in
                                AsyncImage(url: URL(string: photo.thumbnailUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    case .failure:
                                        EmptyView()
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
                    .refreshable {
                        await phtoVM.fetchPhotos()
                    }
                }
            }
            .searchable(text: $phtoVM.searchText, prompt: "搜尋照片標題")
        }
        .task {
            await phtoVM.fetchPhotos()
        }
    }
}

#Preview {
    PhotosView()
}
