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
    let urlString = "https://www.instagram.com/ingracristin/"
    var viewModel : ViewModel
    
    init(vm : ViewModel) {
        self.coordinator.viewModel = vm
        self.viewModel = vm
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var viewModel : ViewModel!
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.innerHTML") { result, error in
                guard let html = result as? String, error == nil else {
                    return
                }

                let document = HTMLDocument(string: html)
                let allImages: [String] = document.querySelectorAll("img").compactMap { element in
                    guard let image = element.attributes["src"] as? String else {
                        return nil
                    }
                    return image
                }
                
                for image in allImages {
                    print(image+"\n")
                }
                
                self.viewModel.imagesUrls = allImages
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
        wb.load(URLRequest(url: URL(string: urlString)!))
        //wb.isHidden = true
        return wb
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<TestWebView>) {
        
    }
}
