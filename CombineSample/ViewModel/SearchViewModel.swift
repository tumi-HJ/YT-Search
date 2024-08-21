//
//  SearchViewModel.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/11.
//

import Foundation
import SwiftUI
import Combine

final class SearchViewModel : ObservableObject {
    
    enum Status {
        case unexecuted // 未実行
        case success    // 成功
        case failed     // 失敗
    }
    
    
    @Published var status : Status
    @Published var isPresentedSafari = false
    @Published var videoUrl : URL
    
    @Published var result: [CardView.Input] = []

    
    private var cancellable = Set<AnyCancellable>()
    
    
    init() throws {
        status = .unexecuted
        videoUrl = URL(string: "https://www.youtube.com/")!
    }
    
    func searchContents(serchText: String){
        print(serchText)
        // 検索キーワードをURLエンコードする
        guard let keyword_encode = serchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        // URLが正しくないならばエラー
        guard let url = URL(string: "https://www.googleapis.com/youtube/v3/search?&key=AIzaSyBRFaPDInG5vJ0uWqKN-LYz5pHXqHwSsdo&type=video&part=snippet&q=\(keyword_encode)") else {
            print("URLが正しくありません")
            status = .failed
            return
        }
        // コンポーネントが作られなければエラー
        guard let component = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            //            throw NSError()
            
            print("コンポーネントが作れません")
            status = .failed
            return
        }

        
        // コンポーネントからURLが作成できなければエラー
        guard component.url != nil else {
            //            throw NSError()
            print("コンポーネントからURLを作成できません")
            status = .failed
            return
        }
        
        let reqURL = URLRequest(url: url)
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        // リクエストをタスクとして登録
        let task = session.dataTask(with: reqURL, completionHandler: {
            (data, response ,error) in
            //Data? URLResponse? Error?が省略
            
            // セッションを終了
            session.finishTasksAndInvalidate()
            
            // do try catch エラーハンドリング
            do {
                // JSONDecoderのインスタンス登録
                let decoder = JSONDecoder()
                // 受け取ったJSONデータをパース（解析）して格納
                let json = try decoder.decode(YoutubeDataJson.self, from: data!)
               
                print(json)
               // self.result = json
                self.status = .success
               //画面表示？
                
                if let items = json.items {
                    self.result.removeAll()
                    for item in items {
                        if let videoId = item.id.videoId,
                           let publishedAt = item.snippet.publishedAt,
                           let channelId = item.snippet.channelId,
                           let title = item.snippet.title,
                           let description = item.snippet.description,
                           let imageUrlString = item.snippet.thumbnails.high.url,
                           let imageUrl = URL(string: imageUrlString),
                           let imageData = try? Data(contentsOf: imageUrl),
                           let thumbnails = UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal),
                           let channelTitle = item.snippet.channelTitle {
                            let youtubeData = CardView.Input(thumbnails: thumbnails, videoTitle: title, description: description, videoPostTime: publishedAt, channelTitle: channelTitle, videoId: videoId, channelId: channelId)
                            self.result.append(youtubeData)
                        }
                            
                           
                    }
         
                    print(self.result)
                }
                
                
                
            } catch {
                // エラー処理
                print(url)
                print("do-catch エラーが出ました")
               
            }
        })
        //ダウンロード開始
        task.resume()
    }
    
    func getVideoURL(videoUrlString: String){
        //urlをstringからURLに
        guard videoUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) != nil else {
            return
        }
        
        videoUrl = URL(string: "https://www.youtube.com/watch?v=\(videoUrlString)")!
        
        //https://www.youtube.com/watch?v=[AKSVu9vnc18]
       
    }
    
    
    ///チャンネルにも飛べるように実装したかったという名残
//    func getChannelURL(){
//        //https://www.youtube.com/channel/[UClKeJXipXwX7_ZGxOBnMQyw
//    }
    
    
    
}
