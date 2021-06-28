
//
//  UserRepository.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/06/21.
//

import Foundation
import FirebaseFirestore

enum Collections: String {
    case users
    case boards
    case posts
}

class UserRepository {
    static let current = UserRepository()
    private let collection = Firestore.firestore().collection(Collections.users.rawValue)
    
    private init() {}
    
    enum UserRepositoryErrors: Error {
        case initializationError(String)
    }
 
    func initialize(user: User,completion: @escaping (Result<User,UserRepositoryErrors>) -> ()) {
        collection.document(user.uid).setData(user.toJson()) { (error) in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.initializationError(err.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            }
        }
    }
}
