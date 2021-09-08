//
//  ImagesLocalRepository.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/09/21.
//

import Foundation
import UIKit

class ImagesLocalRepository {
    static let shared: ImagesLocalRepository = .init()
    
    private init() {}
    
    func getImageFrom(imagePath: String) -> UIImage? {
        if let imageData = UserDefaults.standard.object(forKey: imagePath) as? Data {
            return UIImage(data: imageData)!
        }
        return nil
    }
    
    func save(imageData: Data, on imagePath: String) {
        UserDefaults.standard.setValue(imageData,forKey: imagePath)
    }
    
    func deleteImageFrom(imagePath: String) {
        UserDefaults.standard.removeObject(forKey: imagePath)
    }
    
    func saveImages(urls: [String], on path: String) {
        UserDefaults.standard.set(urls, forKey: path)
    }
    
    func getImagesUrls(from path: String) -> [String] {
        return UserDefaults.standard.object(forKey: path) as? [String] ?? []
    }
}
