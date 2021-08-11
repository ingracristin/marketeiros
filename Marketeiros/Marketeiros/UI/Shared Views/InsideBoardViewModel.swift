//
//  InsideBoardViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 29/06/21.
//

import Foundation
import SwiftUI

class InsideBoardViewModel: ObservableObject {
    @Published var posts = [Post]()
    @Published private(set) var states = States()
    @Published var board: Board
    var changesCallback: (Board) -> ()
    
    struct States {
        var selectedIndex = 0
        var editBoardIsShowing = false
        var addPostScreenShowing = false
        var errorAlertIsShowing = false
        var errorMessage = ""
    }
    
    var bindings: (
        selectedIndex: Binding<Int>,
        addPostScreenShowing: Binding<Bool>,
        editBoardIsShowing: Binding<Bool>,
        errorAlertIsShowing: Binding<Bool>,
        errorMessage: Binding<String>)
     {(
        selectedIndex: Binding(
            get: {self.states.selectedIndex},
            set: {self.states.selectedIndex = $0}),
        addPostScreenShowing: Binding(
            get: {self.states.addPostScreenShowing},
            set: {self.states.addPostScreenShowing = $0}),
        editBoardIsShowing: Binding(
            get: {self.states.editBoardIsShowing},
            set: {self.states.editBoardIsShowing = $0}),
        errorAlertIsShowing:Binding(
            get: {self.states.errorAlertIsShowing},
            set: {self.states.errorAlertIsShowing = $0}),
        errorMessage: Binding(
            get: {self.states.errorMessage},
            set: {self.states.errorMessage = $0})
    )}
    
    init(board: Board, changesCallback: @escaping (Board) -> ()) {
        self.board = board
        self.changesCallback = changesCallback
    }
    
    func change(board: Board) {
        self.board = board
        changesCallback(board)
    }
    
    func toggleAddPostView() {
        states.addPostScreenShowing.toggle()
    }
    
    func toggleEditBoardSheet() {
        states.editBoardIsShowing.toggle()
    }
    
    func setErrorAlertIsShowing(_ value: Bool) {
        states.errorMessage = NSLocalizedString("deleteBoardNow", comment: "")
        states.errorAlertIsShowing = value
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
        let uids = posts.map {$0.uid}
        UserNotificationService.shared.deleteNotificationWith(uids: uids)
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
