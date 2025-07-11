//
//  CommentModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation

struct Comment: Identifiable, Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
