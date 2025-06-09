//
//  SettingView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("nickname") private var nickname = ""
    @AppStorage("userId") private var userId = ""
    @AppStorage("email") private var email = ""
    @AppStorage("city") private var city = ""
    @AppStorage("phone") private var phone = ""
    @AppStorage("avatarURL") private var avatarURL = ""
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 12) {
                    if let url = URL(string: avatarURL) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    }
                    
                    Text("\(nickname)")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Section(header: Text("帳號")) {
                    Text("用戶 ID：\(userId)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("E-Mail：\(email)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    
                    Text("城市：\(city)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("電話：\(phone)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("外觀")) {
                    Toggle("深黑模式", isOn: $isDarkMode)
                }
            }
            .navigationTitle("設定")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        locationManager.requestLocation()
                    } label: {
                        Image(systemName: "location.fill")
                    }
                }
            }
            .onChange(of: locationManager.city) { newCity in
                if !newCity.isEmpty {
                    city = newCity
                }
            }
        }
    }
}

#Preview {
    SettingView()
}
