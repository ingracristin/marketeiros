//
//  InsideBoardViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 29/06/21.
//

import Foundation

class InsideBoardViewModel: ObservableObject {
    @Published private(set) var posts = [Post]()
    
    let board: Board
    
    init(board: Board) {
        self.board = board
    }
    
    func setListenerOnPosts() {
        BoardsRepository.current.setListener(on: .posts, of: board, ofItemType: Post.self) { [weak self] result in
            switch result {
            case .failure(let message):
                print(message)
            case .success(let postsList):
                self!.posts = postsList
            }
        }
    }
}
