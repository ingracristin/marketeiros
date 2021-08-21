//
//  LocalReposotory.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/08/21.
//

import Foundation

class LocalRepository {
    static let shared = LocalRepository()
    
    private init() {}
    
    func saveCurrent(board: Board) {
        do {
            try UserDefaults.standard.setObject(board, forKey: "currentBoard")
        } catch {
            print(error)
        }
    }
    
    func getCurrentBoard() -> Board? {
        do {
            let board = try UserDefaults.standard.getObject(forKey: "currentBoard", castTo: Board.self)
            return board
        } catch {
            print(error)
            return nil
        }
    }
}
