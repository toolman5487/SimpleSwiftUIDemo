import SwiftUI

struct ArticleRow: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("文章標題")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("這是文章的預覽內容，可以顯示前幾行文字...")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)
            
            HStack {
                Text("ID: 1")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ArticleRow()
} 