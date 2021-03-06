//
//  SeiNão.swift
//  instagramScrap
//
//  Created by Gonzalo Ivan Santos Portales on 22/06/21.
//

import Foundation
import WebKit
import SwiftUI
import HTMLKit

struct IgWebView: UIViewRepresentable {
    @Binding var igUser: String
    @Binding var imagesUrls: [ImageUrl]
    static private var account: String = ""
    
    init(igUser: Binding<String>, imagesUrls: Binding<[ImageUrl]>) {
        self._imagesUrls = imagesUrls
        self._igUser = igUser
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        @Binding var igUser: String
        @Binding var imagesUrls: [ImageUrl]
        let localRepository = ImagesLocalRepository.shared
        
        init(igUser: Binding<String>, imagesUrls: Binding<[ImageUrl]>) {
            self._imagesUrls = imagesUrls
            self._igUser = igUser
        }
        
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
                print(allImages)
                
                if allImages.isEmpty || allImages.contains("//static.facebook.com/images/logos/facebook_2x.png"){
                    allImages = self.localRepository.getImagesUrls(from: "instagramUrlsFrom=\(self.igUser)")
                } else {
                    if let first = allImages.first {
                        if first == allImages.last && allImages.count > 1 {
                            allImages.removeLast()
                        }
                        allImages.removeFirst()
                        self.localRepository.saveImages(urls: allImages, on: "instagramUrlsFrom=\(self.igUser)")
                    }
                }
                
                self.imagesUrls = allImages.map({ url in
                    ImageUrl(imageUrl: url)
                })
            }
        }
    }
    // essas outras 3 funções são funções padrão de um ViewRepresentable
    func makeCoordinator() -> IgWebView.Coordinator {
        return Coordinator(igUser: $igUser, imagesUrls: $imagesUrls)
    }

    func makeUIView(context: UIViewRepresentableContext<IgWebView>) -> WKWebView {
        let urlString = "https://www.instagram.com/\(igUser)/"
        let prefs = WKPreferences()
        prefs.javaScriptEnabled = true
        let config = WKWebViewConfiguration()
        config.preferences = prefs
        let wb = WKWebView(frame: .zero, configuration: config)
        wb.navigationDelegate = context.coordinator
        let url = URL(string: urlString)!
        wb.load(URLRequest(url: url))
        //wb.isHidden = true
        return wb
    }

    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<IgWebView>) {
        if IgWebView.account != igUser {
            let urlString = "https://www.instagram.com/\(igUser)/"
            IgWebView.account = igUser
            let url = URL(string: urlString)!
            uiView.load(URLRequest(url: url))
        }
    }
}
