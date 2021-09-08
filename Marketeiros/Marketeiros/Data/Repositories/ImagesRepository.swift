
// ImagesRepository
//  metodum
//
//  Created by Gonzalo Ivan Santos Portales on 29/09/20.
//  Copyright © 2020 metodum. All rights reserved.
//

import Foundation
import FirebaseStorage

// isso aqui é pra caso a gente for botar alguma coisa de acessibilidade no futuro
enum ImagesAcessibilityAtributes : String {
    case acessibilityLabel_pt
    case acessibilityHint_pt
    case acessibilityLabel_en
    case acessibilityHint_en
}

//boardUid/capa.png
//boardUid/posts/postUid
//boardUid/moodBoard/moodBoardUid
//users/userUid.png
class ImagesRepository {
    static let current = ImagesRepository()
    private let storageRoot = Storage.storage().reference()
    private let localRepository = ImagesLocalRepository.shared
    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    enum ImagesRepositoryErrors: Error {
        case errorGettingImage(String)
        case errorSendingImage(String)
        case errorDeletingImage(String)
    }
    
    func upload(imageData data: Data, of post: Post, ofBoard board: Board, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/posts/\(post.uid)"
        upload(imageData: data, to: imagePath, progressCallback: progressCallback, completion: completion)
    }
    
    func getImage(of post: Post, ofBoard board: Board, completion: @escaping (Result<UIImage,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/posts/\(post.uid)"
        getImage(of: imagePath , completion: completion)
    }
    
    func deleteImage(of post: Post, ofBoard board: Board, completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/posts/\(post.uid)"
        deleteImage(of: imagePath, completion: completion)
    }
    
    func upload(imageData data: Data, of board: inout Board, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        board.imagePath = imagePath
        upload(imageData: data, to: imagePath, progressCallback: progressCallback, completion: completion)
    }
    
    func getImage(of board: Board, completion: @escaping (Result<UIImage, ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        getImage(of: imagePath , completion: completion)
    }
    
    func deleteImage(of board: Board, completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        deleteImage(of: imagePath, completion: completion)
    }
    
    func getImageOfScheduledPost(withUid uid: String, ofBoardWithUid boardUid: String) -> UIImage {
        let imagePath = "\(boardUid)/posts/\(uid)"
        return localRepository.getImageFrom(imagePath: imagePath) ?? UIImage(named: "ImageTest")!
    }
    
    private func deleteImage(of path: String, completion: @escaping (Result<Bool, ImagesRepositoryErrors>) -> ()) {
        localRepository.deleteImageFrom(imagePath: path)
        let imageRef = storageRoot.child(path)
        imageRef.delete { error in
            if let error = error {
                completion(.failure(.errorDeletingImage(error.localizedDescription)))
            } else {
                completion(.success(true))
            }
        }
    }
    
    private func getImage(of path: String, completion: @escaping (Result<UIImage, ImagesRepositoryErrors>) -> ()) {
        if let cachedImage = cache.object(forKey: path as NSString) {
            completion(.success(cachedImage))
            return
        }
        
        if let image = localRepository.getImageFrom(imagePath: path) {
            completion(.success(image))
            return
        }
        
        let imageRef = storageRoot.child(path)
        
        imageRef.getData(maxSize: .max) { (imageData, error) in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingImage(errorMessage)))
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    let image = UIImage(data: imageData!)!
                    self!.cache.setObject(image, forKey: path as NSString)
                    self!.localRepository.save(imageData: imageData!, on: path)
                    completion(.success(image))
                }
            }
        }
    }
    
    private func upload(imageData data: Data, to imagePath: String, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imageRef = storageRoot.child(imagePath)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        localRepository.save(imageData: data, on: imagePath)
        
        let uploadProgressTask = imageRef.putData(data, metadata: metadata) { (_, error) in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async {
                    completion(.failure(.errorSendingImage(errorMessage)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
        
        uploadProgressTask.observe(.progress) { snapshot in
            let percentComplete = 100.0 * Double(snapshot.progress!.completedUnitCount) / Double(snapshot.progress!.totalUnitCount)
            print(percentComplete)
            DispatchQueue.main.async {
                progressCallback(percentComplete)
            }
        }
    }
}
