//
//  YoutubeData.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/11.
//

import Foundation



    struct YoutubeDataJson: Decodable {
        let pageInfo : PageInfo
        
        struct PageInfo : Decodable{
            let totalResults: Int?
            let resultsPerPage: Int?
        }
        
        let items: [Items]?
        struct Items : Decodable {
            
            let id: Id
            struct Id :Decodable {
                let kind: String? //表示するもののタイプ。#channel,#video,#playlist とかかな
                // let channelId: String? //kind == #channel
                let videoId : String?
                
            }
            
            let snippet : Snippet
            struct Snippet : Decodable {
                let publishedAt : String?
                let channelId: String?
                let title: String?
                let description: String?
                
                let thumbnails: Thumbnails
                struct Thumbnails: Decodable {
                    let high: High
                    struct High : Decodable {
                        let url: String?
                    }
                }
                
                let channelTitle: String?
                let liveBroadcastContent: String?
                let publishTime : String?
                
                
                
                
            }
            
        }
        
        
    }
    
    



//"snippet": {
//"publishedAt": "2011-07-19T11:31:43Z",
//"channelId": "UCZf__ehlCEBPop-_sldpBUQ",
//"title": "HikakinTV",
//"description": "HikakinTVはヒカキンが面白いものを紹介するチャンネルです。 ◇プロフィール◇ YouTubeに ...",
//"thumbnails": {
//  "default": {
//    "url": "https://yt3.ggpht.com/ytc/AKedOLRClSkZ-Is7IyVjR_5X3yRyN7WgCBOhy-aAygpE0Q=s88-c-k-c0xffffffff-no-rj-mo"
//  },
//  "medium": {
//    "url": "https://yt3.ggpht.com/ytc/AKedOLRClSkZ-Is7IyVjR_5X3yRyN7WgCBOhy-aAygpE0Q=s240-c-k-c0xffffffff-no-rj-mo"
//  },
//  "high": {
//    "url": "https://yt3.ggpht.com/ytc/AKedOLRClSkZ-Is7IyVjR_5X3yRyN7WgCBOhy-aAygpE0Q=s800-c-k-c0xffffffff-no-rj-mo"
//  }
//},
//"channelTitle": "HikakinTV",
//"liveBroadcastContent": "none",      or "live"
//"publishTime": "2011-07-19T11:31:43Z" //多分チャンネルの作成日時。
//}
