//
//  SafariView.swift
//  CombineSample
//
//  Created by cmStudent on 2022/07/12.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable{
    typealias UIViewControllerType = SFSafariViewController
    var url : URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        
        return SFSafariViewController(url: url)
        
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        //
    }
    
    
    
}
