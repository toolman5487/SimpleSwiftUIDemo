import SwiftUI

struct ArticlesView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(0..<10) { _ in
                    ArticleRow()
                }
            }
            .navigationTitle("文章列表")
            .searchable(text: $searchText, prompt: "搜尋文章")
        }
    }
}

#Preview {
    ArticlesView()
} 