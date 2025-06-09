//
//  UserDataDefaults.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import Foundation

struct UserDataDefaults {
    static func register() {
        UserDefaults.standard.register(defaults: [
            "isDarkMode": false,
            "nickname": "Willy123",
            "userId": "A123456",
            "email": "demo@example.com",
            "avatarURL": "https://images.pexels.com/photos/30227186/pexels-photo-30227186/free-photo-of-modern-glass-facade-of-apple-store-building.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            "city": "Unknown",
            "phone": "0912-345-678"
        ])
    }
}
