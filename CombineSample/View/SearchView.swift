//
//  SearchView.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/11.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel : SearchViewModel

    @State var inputText = ""
    
    init() {
        do {
           viewModel =  try SearchViewModel()
        } catch {
            fatalError("URL Error")
        }
       
    }
    
    var body: some View {
        VStack{
            
            Text("Youtube検索")
                .font(.title)
            
            TextField("検索ワードを入力してください", text: $inputText, onCommit: {
                //
                //キーワードを入力し終わって、エンターした時の動作
                viewModel.searchContents(serchText: inputText)
                
            })
            .padding()
            
            Group{
                List(viewModel.result){ data in
                    Button {
                        
                        viewModel.getVideoURL(videoUrlString: data.videoId)
                        viewModel.isPresentedSafari = true
                    } label: {
                        CardView(input: data)
                    }
                    
                }
            }
                
          
            
        } //VStack
        .sheet(isPresented: $viewModel.isPresentedSafari) {
            SafariView(url: viewModel.videoUrl)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
