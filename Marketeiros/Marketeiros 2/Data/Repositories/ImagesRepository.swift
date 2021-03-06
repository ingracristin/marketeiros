
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
//boardUid/postUid/postImage.png
//userUid/fotoPerfil.png
class ImagesRepository {
    static let current = ImagesRepository()
    private let storageRoot = Storage.storage().reference()
    private let cache = NSCache<NSString,UIImage>()
    
    private init() {}
    
    enum ImagesRepositoryErrors: Error {
        case errorGettingImageFromPost(String)
        case errorDeletingImage(String)
    }
    
    func upload(imageData data: Data, of post: Post, ofBoard board: Board, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/\(post.uid)"
        upload(imageData: data, to: imagePath, progressCallback: progressCallback, completion: completion)
    }
    
    func upload(imageData data: Data, of board: inout Board, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        board.imagePath = imagePath
        upload(imageData: data, to: imagePath, progressCallback: progressCallback, completion: completion)
    }
    
    func getImage(of post: Post, ofBoard board: Board, completion: @escaping (Result<UIImage,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/\(post.uid)"
        if let imageData = UserDefaults.standard.object(forKey: imagePath) as? Data {
            completion(.success(UIImage(data: imageData)!))
        } else {
            getImage(of: imagePath , completion: completion)
        }
    }
    
    func getImage(of board: Board, completion: @escaping (Result<UIImage, ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        if let imageData = UserDefaults.standard.object(forKey: imagePath) as? Data {
            completion(.success(UIImage(data: imageData)!))
        } else {
            getImage(of: imagePath , completion: completion)
        }
    }
    
    func deleteImage(of post: Post, ofBoard board: Board, completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/\(post.uid)"
        deleteImage(of: imagePath, completion: completion)
    }
    
    func deleteImage(of board: Board, completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imagePath = "\(board.uid)/cover.png"
        deleteImage(of: imagePath, completion: completion)
    }
    
    func deleteImage(of path: String, completion: @escaping (Result<Bool, ImagesRepositoryErrors>) -> ()) {
        UserDefaults.standard.removeObject(forKey: path)
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
        
        let imageRef = storageRoot.child(path)
        
        imageRef.getData(maxSize: .max) { (imageData, error) in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingImageFromPost(errorMessage)))
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    let image = UIImage(data: imageData!)!
                    self!.cache.setObject(image, forKey: path as NSString)
                    UserDefaults.standard.setValue(imageData,forKey: path)
                    completion(.success(image))
                }
            }
        }
    }
    
    private func upload(imageData data: Data, to imagePath: String, progressCallback: @escaping (Double) -> (), completion: @escaping (Result<Bool,ImagesRepositoryErrors>) -> ()) {
        let imageRef = storageRoot.child(imagePath)
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        let uploadProgressTask = imageRef.putData(data, metadata: metadata) { (_, error) in
            if let errorMessage = error?.localizedDescription {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingImageFromPost(errorMessage)))
                }
            } else {
                DispatchQueue.main.async {
                    UserDefaults.standard.setValue(data,forKey: imagePath)
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
