//
//  CardView.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/11.
//

import SwiftUI
import Combine

struct CardView: View {
   
    struct Input: Identifiable {
        let id: UUID = UUID()
        
        let thumbnails: UIImage
        let videoTitle: String
        let description: String?
        let videoPostTime: String
        let channelTitle: String
        
        let videoId: String
        let channelId: String
        
    }
    
    let input: Input

    var body: some View {
        VStack{
            VStack(alignment: .leading){
                videoTitle
                channelTitle
                videoPostTime
            }
            .padding()
            
            thumbnails
            VStack(alignment: .leading){
                
                description
            }
        }
        .padding()
    }
    
    var thumbnails : some View {
        
        
        Image(uiImage: input.thumbnails)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            
    }
    
    var videoTitle : some View {
        Text(input.videoTitle)
            .font(.title2)
            .foregroundColor(.black)
            .fontWeight(.bold)
    }
    
    var videoPostTime: some View {
        ///Combine で時間を見やすく加工したかった。。。
//        Text(timeEncode(time: input.videoPostTime))
//            .foregroundColor(.black)
        Text(input.videoPostTime)
            .foregroundColor(.black)

    }
    
    var description : some View {
        Text(input.description ?? "")
            .foregroundColor(.black)
            .lineLimit(nil)
    }
    
    var channelTitle: some View{
        Text(input.channelTitle)
            .foregroundColor(.black)
    }
    
    func timeEncode(time: String) -> AnyPublisher<String, Error>{
        return Future<String, Error>{ promise in
            time.replacingOccurrences(of: "T", with: " ")
            time.replacingOccurrences(of: "Z", with: " ")
            promise(.success(time))
            print(time)
        }
        .eraseToAnyPublisher()
    }

}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(input: CardView.Input(thumbnails: UIImage(named: "hqdefault")! , videoTitle: "動画タイトル", description: "動画説明文", videoPostTime: "yyyy-mm-dd-Ttt:mm:ssZ", channelTitle: "チャンネル名", videoId: "AKSVu9vnc18", channelId: "UClKeJXipXwX7_ZGxOBnMQyw"))
    }
}
