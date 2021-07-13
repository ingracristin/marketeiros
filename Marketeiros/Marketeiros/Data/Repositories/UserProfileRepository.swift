
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
    case pastes
    case ideas
}

class UserProfileRepository {
    static let current = UserProfileRepository()
    private let collection = Firestore.firestore().collection(Collections.users.rawValue)
    
    private init() {}
    
    enum UserRepositoryErrors: Error {
        case initializationError(String)
    }
 
    func initialize(user: UserProfile,completion: @escaping (Result<UserProfile,UserRepositoryErrors>) -> ()) {
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
    
    func getUserWith(uid: String,completion: @escaping (Result<UserProfile,UserRepositoryErrors>) -> ()) {
        collection.document(uid).getDocument { snapshot, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.initializationError(err.localizedDescription)))
                }
            } else {
                let user = UserProfile.from(json: snapshot!.data()!)
                DispatchQueue.main.async {
                    completion(.success(user))
                }
            }

        }
    }
}
