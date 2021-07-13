//
//  InsideBoardViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 29/06/21.
//

import Foundation
import SwiftUI

class InsideBoardViewModel: ObservableObject {
    @Published private(set) var posts = [Post]()
    @Published private(set) var states = States()
    let board: Board
    
    struct States {
        var selectedIndex = 0
        var addPostScreenShowing = false
    }
    
    var bindings: (
        selectedIndex: Binding<Int>,
        addPostScreenShowing: Binding<Bool>
    ) {(
        selectedIndex: Binding(
            get: {self.states.selectedIndex},
            set: {self.states.selectedIndex = $0}),
        addPostScreenShowing: Binding(
            get: {self.states.addPostScreenShowing},
            set: {self.states.addPostScreenShowing = $0})
    )}
    
    init(board: Board) {
        self.board = board
    }
    
    func toggleAddPostView() {
        states.addPostScreenShowing.toggle()
    }
    
    func getAllPosts() {
        BoardsRepository.current.getAllItens(of: board, on: .posts,ofItemType: Post.self) { result in
            switch result {
            case .failure(let message):
                print(message)
            case .success(let postsList):
                self.posts = postsList
            }
        }
    }
    
    func deleteBoard(completion: @escaping (Bool) -> ()) {
        BoardsRepository.current.delete(board: board) { result in
            switch result {
            case .failure(_):
                completion(false)
            case .success(_):
                completion(true)
            }
        }
    }
}
