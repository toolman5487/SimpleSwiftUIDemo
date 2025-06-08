//
//  PostModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import Foundation

struct Article: Identifiable, Codable, Equatable {
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
