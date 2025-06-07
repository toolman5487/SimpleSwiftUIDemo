//
//  PhotoService.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation

class PhotoService {

    func fetchPhotos() async throws -> [Photo] {
        let url = APIConfig.baseURL.appendingPathComponent("photos")
        let (data, _) = try await URLSession.shared.data(from: url)
        var photos = try JSONDecoder().decode([Photo].self, from: data)
        
        photos = photos.map { photo in
            var modifiedPhoto = photo
            modifiedPhoto.thumbnailUrl = "https://picsum.photos/150/150?random=\(photo.id)"
            return modifiedPhoto
        }
        
        return photos
    }

}
