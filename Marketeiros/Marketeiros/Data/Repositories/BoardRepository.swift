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
        case errorAddingItemToBoard(String)
        case errorGettingItemsOfBoard(String)
        case errorDeletingItemsFromBoard(String)
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
    
    func setListener(on board: Board, of user: User,completion: @escaping (Result<[Board],BoardsRepositoryErrors>) -> ()) {
        collection.addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
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
    
    func create(board: inout Board, completion: @escaping (Result<Bool,BoardsRepositoryErrors>) -> ()){
        let docRef = collection.addDocument(data: board.toJson()) { error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.boardsCollectionError(err.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
        docRef.updateData(["uid": docRef.documentID])
        board.uid = docRef.documentID
    }
    
    func delete(board: Board, completion: @escaping (Result<Bool,BoardsRepositoryErrors>) -> ()){
        collection.document(board.uid).delete { error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.boardsCollectionError(err.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
    }
}

// Generic functions do all of the boards subitens
extension BoardsRepository {
    func add<T: BoardItemSavable>(item: inout T, to board: Board, on itemCollection: Collections) {
        let docRef = collection.document(board.uid).collection(itemCollection.rawValue).addDocument(data: item.toJson())
        docRef.updateData(["uid": docRef.documentID])
        item.uid = docRef.documentID
    }
    
    func delete<T: BoardItemSavable>(item: T, to board: Board, on itemCollection: Collections, completion: @escaping (Result<Bool, BoardsRepositoryErrors>) -> ()) {
        collection.document(board.uid).collection(itemCollection.rawValue).document().delete { error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.errorDeletingItemsFromBoard(err.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
    }

    func getAllItens<T: BoardItemSavable>(of board: Board, on itemCollection: Collections, ofItemType: T.Type, completion: @escaping (Result<[T], BoardsRepositoryErrors>) -> ()) {
        get(collection: itemCollection, of: board).getDocuments { snapshot, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingItemsOfBoard(err.localizedDescription)))
                }
            } else {
                var items = [T]()
                for doc in snapshot!.documents {
                    let item : T = T.from(json: doc.data()) as! T
                    items.append(item)
                }
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            }
        }
    }
    
    func setListener<T: BoardItemSavable>(on itemCollection: Collections, of board: Board, ofItemType: T.Type ,completion: @escaping (Result<[T],BoardsRepositoryErrors>) -> ()) {
        get(collection: itemCollection, of: board).addSnapshotListener(includeMetadataChanges: false) { snapshot, error in
            if let err = error {
                DispatchQueue.main.async {
                    completion(.failure(.errorGettingItemsOfBoard(err.localizedDescription)))
                }
            } else {
                var items = [T]()
                for doc in snapshot!.documents {
                    let item : T = T.from(json: doc.data()) as! T
                    items.append(item)
                }
                DispatchQueue.main.async {
                    completion(.success(items))
                }
            }
        }
    }

    private func get(collection itemCollection: Collections,of board: Board) -> CollectionReference {
        return collection.document(board.uid).collection(itemCollection.rawValue)
    }
}
