//
//  SocialNetworkService.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 14/06/21.
//

import Foundation
import UIKit

class SocialNetworkService {
    enum SocialNetworks: String {
        case instagram = "instagram"
        case tiktok = "musically"
    }
    
    static let shared = SocialNetworkService()
    
    private init () {}

    func open(socialNetwork : SocialNetworks, andSend data : [String : Any]) {
        let imageAsset = data["imagePath"] as! String
        let description = data["description"] as! String
        var urlScheme : URL!
        
        switch socialNetwork {
        case .instagram:
            urlScheme = URL(string: "\(socialNetwork.rawValue)://library?AssetPath=\(imageAsset)")
        case .tiktok:
            urlScheme = URL(string: "\(socialNetwork.rawValue)://AssetPath=\(imageAsset)")
        }
        
        DispatchQueue.main.async {
            if !imageAsset.isEmpty,
               let url = urlScheme {
                if UIApplication.shared.canOpenURL(url) {
                    UIPasteboard.general.string = description
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
