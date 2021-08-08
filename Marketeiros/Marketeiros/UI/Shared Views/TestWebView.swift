//
//  SeiNão.swift
//  instagramScrap
//
//  Created by Gonzalo Ivan Santos Portales on 22/06/21.
//

import Foundation
import WebKit
import SwiftUI
import HTMLKit

struct TestWebView: UIViewRepresentable {
    let coordinator = Coordinator()
    let urlString: String
    var viewModel: ViewModel
    
    init(vm : ViewModel) {
        self.coordinator.viewModel = vm
        self.viewModel = vm
        self.urlString = "https://www.instagram.com/\(vm.igUser)/"
        print(urlString)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var viewModel : ViewModel!
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String, error == nil else {
                    return
                }

                let document = HTMLDocument(string: html)
                var allImages: [String] = document.querySelectorAll("img").compactMap { element in
                    guard let image = element.attributes["src"] as? String else {
                        return nil
                    }
                    return image
                }
                
                
                if let _ = allImages.first {
                    allImages.removeFirst()
                }
                
                self.viewModel.imagesUrls = allImages.map({ url in
                    ImageUrl(imageUrl: url)
                })
            }
        }
    }
    // essas outras 3 funções são funções padrão de um ViewRepresentable
    func makeCoordinator() -> TestWebView.Coordinator {
        return coordinator
    }

    func makeUIView(context: UIViewRepresentableContext<TestWebView>) -> WKWebView {
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        let wb = WKWebView(frame: .zero, configuration: config)
        wb.navigationDelegate = coordinator
        let url = URL(string: urlString)!
        wb.load(URLRequest(url: url))
        //wb.isHidden = true
        return wb
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<TestWebView>) {
        
    }
}
