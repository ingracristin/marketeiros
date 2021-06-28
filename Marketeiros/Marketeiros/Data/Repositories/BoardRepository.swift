//
//  BoardRepository.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 25/06/21.
//

import Foundation
import FirebaseFirestore

class BoardsRepository {
    static let current = BoardsRepository()
    private let collection = Firestore.firestore().collection(Collections.boards.rawValue)
    
    private init() {}
    
    enum BoardsRepositoryErrors: Error {
        case boardCreationError(String)
        case boardsCollectionError(String)
        case errorAddingPostToBoard(String)
        case errorGettingPostsOfBoard(String)
    }
 
    func getAllBoards(of user: User, completion: @escaping (Result<[Board],BoardsRepositoryErrors>) -> ()) {
        collection.whereField("ownerUid", in: [user.uid]).getDocuments { snapshot, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.boardsCollectionError(err.localizedDescription)))
                }
            } else {
                var boards = [Board]()
                for doc in snapshot!.documents {
                    boards.append(Board.from(json: doc.data()))
                }
                DispatchQueue.main.async {
                    completion(.success(boards))
                }
            }
        }
    }
    
    func create(board : inout Board) -> Board {
        let docRef = collection.addDocument(data: board.toJson())
        docRef.updateData(["uid": docRef.documentID])
        board.uid = docRef.documentID
        return board
    }
}

// Posts related functions
extension BoardsRepository {
    func add(post: Post, to board: Board) {
        collection.document(board.uid).collection(Collections.posts.rawValue).addDocument(data: post.toJson())
    }
    
    func getAllPosts(of board: Board, completion: @escaping (Result<[Post], BoardsRepositoryErrors>) -> ()) {
        postsCollection(for: board).getDocuments { [weak self] snapshot, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingPostsOfBoard(err.localizedDescription)))
                }
            } else {
                var posts = [Post]()
                for doc in snapshot!.documents {
                    posts.append(self!.convert(json: doc.data()))
                }
                DispatchQueue.main.async {
                    completion(.success(posts))
                }
            }
        }
    }
    
    private func convert(json: [String: Any]) -> Post {
        let firebaseDate = json["dateOfPublishing"] as! Timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(firebaseDate.seconds))
        
        return Post.from(json: json,with: date)
    }
 
    private func postsCollection(for board: Board) -> CollectionReference {
        return collection.document(board.uid).collection(Collections.posts.rawValue)
    }
}
