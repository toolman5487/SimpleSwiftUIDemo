//
//  VideoView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//

import SwiftUI
import AVKit

struct VideoHomeView: View {
    @StateObject private var pixabayVM = PixabayVideoViewModel()
    
    var body: some View {
        NavigationView {
            List(pixabayVM.filteredVideos, id: \.id) { video in
                NavigationLink {
                    VideoDetailView(video: video)
                } label: {
                    VStack (alignment: .leading){
                        AsyncImage(url: video.videos.tiny.thumbnail) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(width: 320, height: 180)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(16/9, contentMode: .fill)
                                    .frame(width: 320, height: 180)
                                    .cornerRadius(16)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo")
                                    .frame(width: 320, height: 180)
                                    .foregroundColor(Color.secondary)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        HStack {
                            AsyncImage(url: video.userImageURL) { phase in
                                switch phase {
                                case .empty:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(Color.secondary)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                case .failure:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(Color.secondary)
                                @unknown default:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(Color.secondary)
                                }
                            }
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            
                            Text(video.tags.split(separator: ",").first.map(String.init) ?? "Unknow")
                                .font(.title3)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .padding(.leading, 8)
                        }
                        
                        HStack{
                            Text(video.user)
                                .lineLimit(1)
                            Spacer()
                            Text("觀看次數：\(video.likes)")
                                .lineLimit(1)
                        }
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
    
            .navigationTitle("影片列表")
            .onAppear {
                pixabayVM.fetchVideos()
            }
            .searchable(text: $pixabayVM.searchText, prompt: "搜尋標籤/作者")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingView()) {
                        Image(systemName: "gearshape")
                    }
                }
            }
        }

    }
}

#Preview {
    VideoHomeView()
}
