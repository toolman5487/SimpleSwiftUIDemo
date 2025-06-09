//
//  PhotoModel.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//


import Foundation

struct Photo: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    var thumbnailUrl: String
}
