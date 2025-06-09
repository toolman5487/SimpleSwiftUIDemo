//
//  RelatedVideosView.swift
//  JSONPlaceholderDemo
//
//  Created by Willy Hsu on 2025/6/9.
//

import SwiftUI

struct RelatedVideosView: View {
    
    let relatedVideos: [VideoHit]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("相關影片")
                .font(.headline)
                .padding(.horizontal)
            ForEach(relatedVideos) { relatedVideo in
                NavigationLink(destination: VideoDetailView(video: relatedVideo)) {
                    HStack {
                        AsyncImage(url: relatedVideo.videos.tiny.thumbnail) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(16/9, contentMode: .fill)
                                    .frame(width: 160, height: 90)
                                    .clipped()
                                    .cornerRadius(16)
                            } else if phase.error != nil {
                                Color.gray
                                    .frame(width: 160, height: 90)
                                    .cornerRadius(8)
                            } else {
                                ProgressView()
                                    .frame(width: 160, height: 90)
                                    .cornerRadius(8)
                            }
                        }
                        LazyVStack(alignment: .leading) {
                            Text(relatedVideo.tags.split(separator: ",").first.map(String.init) ?? "Unknow")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.primary)
                                .lineLimit(1)
                            Text("作者：\(relatedVideo.user)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                Divider()
            }
        }
    }
}


#Preview {
    RelatedVideosView(relatedVideos: [
        VideoHit(
            id: 275633,
            pageURL: URL(string: "https://pixabay.com/videos/id-275633/")!,
            type: "film",
            tags: "sea, wave, beach",
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
    ])
}
