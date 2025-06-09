# JSONPlaceholderDemo
一個使用 SwiftUI 結合 Combine 與 `async/await` 技術，串接 [JSONPlaceholder](https://jsonplaceholder.typicode.com/) 與 [Pixabay](https://pixabay.com/) API，展示文章、相片與影片內容的多媒體示範應用程式。

## 技術
- 語言與框架：Swift 5, SwiftUI, Combine, async/await  
- 網路層：URLSession + Combine / async/await  
- 動畫：Lottie for iOS  
- 資料儲存：UserDefaults (`UserDataDefaults.swift`)  
- 依賴管理：純 Swift Package / CocoaPods（如有）  

## 功能特色
- **文章瀏覽**  
  - 透過 `ArticleService` 串接 JSONPlaceholder API，顯示文章列表、內文及留言。  
  - 利用 Combine + `async/await` 管理載入狀態與錯誤處理，並在更新時顯示 Lottie 動畫。  

- **相片搜尋**  
  - 透過 `PhotoService` 串接 Pixabay Image API，支援關鍵字搜尋、分頁顯示與快取策略。  
  - 在下拉更新與載入更多時，顯示自訂 Lottie 動畫組件。  

- **影片播放**  
  - 使用 `PixabayVideoService` 獲取影片清單，並在 `VideoDetailView` 中以 AVKit 播放。  
  - 支援全螢幕播放與重播控制。  

- **使用者設定**  
  - 透過 `UserDataDefaults.swift` 管理主題、暱稱、城市等偏好設定，並以 `@AppStorage` 自動綁定至 UI。  

## 開始使用
1. **Clone 專案**  
   ```bash
   git clone https://github.com/你的帳號/JSONPlaceholderDemo.git
   cd JSONPlaceholderDemo
2.	**設定 API Key**  
	•	在 Services/APIConfig/PixabayAPIConfig.swift：
  - struct PixabayAPIConfig {
    static let apiKey = "YOUR_PIXABAY_API_KEY"
3.	**執行專案**  
	•	開啟 JSONPlaceholderDemo.xcodeproj。
	•	選擇模擬器或真機，按下 Run (⌘R) 即可。

## 架構說明
- 採用 MVVM 模式：
- ViewModels/：負責呼叫 Services，處理資料並透過 @Published 推送至 View。
- Views/：純 UI，依賴對應的 ViewModel 顯示資料與處理互動。
- Service 層：
- ArticleService、PhotoService、PixabayVideoService 分別封裝 API 請求邏輯。
- APIConfig 統一管理 Base URL、API Key。
- 動畫整合：
- 自訂 MakeAnimationView 封裝 Lottie 動畫，並在各種互動場景中呼叫。

##本專案採用 MIT License，歡迎自由使用與修改。
