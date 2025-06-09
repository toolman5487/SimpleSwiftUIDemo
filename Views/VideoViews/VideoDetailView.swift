//
//  VideoDetailView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/7.
//


import SwiftUI
import AVKit

struct VideoDetailView: View {
    
    let video: VideoHit
    @StateObject private var viewModel = PixabayVideoViewModel()
    
    var body: some View {
        ScrollView {
            VideoPlayer(player: AVPlayer(url: video.videos.large.url))
                .aspectRatio(16/9, contentMode: .fit)
                .edgesIgnoringSafeArea(.horizontal)
            
            VStack(alignment: .leading, spacing: 12) {
                Text(video.tags.split(separator: ",").first.map(String.init) ?? "未命名影片")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack(spacing: 12) {
                    AsyncImage(url: video.userImageURL) { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        } else if phase.error != nil {
                            Circle().fill(Color.gray)
                                .frame(width: 40, height: 40)
                        } else {
                            ProgressView()
                                .frame(width: 40, height: 40)
                        }
                    }
                    Text(video.user)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                .padding(.horizontal)
                
                Text("\(video.views) 次觀看")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 24) {
                        HStack(spacing: 6) {
                            Image(systemName: "hand.thumbsup")
                            Text("\(video.likes)")
                        }
                        .capsuleButtonStyle()
                        
                        HStack(spacing: 6) {
                            Image(systemName: "person.3")
                            Text("評論")
                        }
                        .capsuleButtonStyle()
                        
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.down.to.line.compact")
                            Text("\(video.downloads)")
                        }
                        .capsuleButtonStyle()
                        
                        HStack(spacing: 6) {
                            Image(systemName: "bookmark")
                            Text("典藏")
                        }
                        .capsuleButtonStyle()
                    }
                    .font(.subheadline)
                    .padding(.horizontal)
                }
                
                Divider()
                    .padding(.vertical, 8)
                
                if !viewModel.relatedVideos.isEmpty {
                   RelatedVideosView(relatedVideos: viewModel.relatedVideos)
                } else {
                   MakeAnimationView(animationName: "Animation_popcorn")
                        .frame(width: 300, height: 300)
                        .padding(.horizontal)
                }
            }
        }
        .onAppear {
            viewModel.fetchRelatedVideos(tags: video.tags, currentVideoId: video.id)
        }
        .navigationTitle("影片詳情")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let sampleVideo = VideoHit(
        id: 275633,
        pageURL: URL(string: "https://pixabay.com/videos/id-275633/")!,
        type: "film",
        tags: "sea, wave, beach, sunset, ocean, sunrise, sunlight, seascape, shore, coastline, island, cliff, coast, splashing, seacoast, light, coastal, splash, shining, stormy, rock, sun",
        duration: 54,
        videos: VideoVariants(
            large: VideoFile(
                url: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_large.mp4")!,
                width: 1920,
                height: 1080,
                size: 65844859,
                thumbnail: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_large.jpg")!
            ),
            medium: VideoFile(
                url: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_medium.mp4")!,
                width: 1280,
                height: 720,
                size: 28282786,
                thumbnail: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_medium.jpg")!
            ),
            small: VideoFile(
                url: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_small.mp4")!,
                width: 960,
                height: 540,
                size: 18655325,
                thumbnail: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_small.jpg")!
            ),
            tiny: VideoFile(
                url: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_tiny.mp4")!,
                width: 640,
                height: 360,
                size: 10101738,
                thumbnail: URL(string: "https://cdn.pixabay.com/video/2025/04/29/275633_tiny.jpg")!
            )
        ),
        views: 28845,
        downloads: 23815,
        likes: 348,
        comments: 43,
        userId: 34815979,
        user: "Mario_Krimer",
        userImageURL: URL(string: "https://cdn.pixabay.com/user/2025/04/21/12-36-03-69_250x250.jpg")!,
        noAiTraining: true
    )
    VideoDetailView(video: sampleVideo)
}
