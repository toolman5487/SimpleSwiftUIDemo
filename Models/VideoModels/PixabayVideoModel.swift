//
//  PixabayVideoModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import Foundation

struct PixabayVideoResponse: Codable {
    let total: Int
    let totalHits: Int
    let hits: [VideoHit]
}

struct VideoHit: Codable, Identifiable {
    let id: Int
    let pageURL: URL
    let type: String
    let tags: String
    let duration: Int
    let videos: VideoVariants
    let views: Int
    let downloads: Int
    let likes: Int
    let comments: Int
    let userId: Int
    let user: String
    let userImageURL: URL
    let noAiTraining: Bool

    enum CodingKeys: String, CodingKey {
        case id, type, tags, duration, videos, views, downloads, likes, comments, user, noAiTraining
        case pageURL = "pageURL"
        case userId = "user_id"
        case userImageURL = "userImageURL"
    }
}

struct VideoVariants: Codable {
    let large: VideoFile
    let medium: VideoFile
    let small: VideoFile
    let tiny: VideoFile
}

struct VideoFile: Codable {
    let url: URL
    let width: Int
    let height: Int
    let size: Int
    let thumbnail: URL
}
