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
    @Published private(set) var board: Board = Board.init(
        uid: "",
        imagePath: "",
        title: "Plani Board",
        description: "",
        instagramAccount: "",
        ownerUid: "",
        colaboratorsUids: [],
        postsGridUid: "",
        ideasGridUid: "",
        moodGridUid: "")
    @Published private(set) var boards = [Board]()
    var changesCallback: (Board) -> ()
    
    var screenNavTitle: String {
        let title = self.board.instagramAccount.removeCharactersContained(in: "@")
        return (title.isEmpty) ? "@username" : "@\(title)"
    }
    
    struct States {
        var selectedIndex = 0
        var editBoardIsShowing = false
        var addPostScreenShowing = false
        var errorAlertIsShowing = false
        var errorMessage = ""
        var isLoading = false
        var igAccount = ""
    }
    
    var bindings: (
        selectedIndex: Binding<Int>,
        addPostScreenShowing: Binding<Bool>,
        editBoardIsShowing: Binding<Bool>,
        errorAlertIsShowing: Binding<Bool>,
        errorMessage: Binding<String>,
        isLoading: Binding<Bool>,
        igAccount: Binding<String>)
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
            set: {self.states.errorMessage = $0}),
        isLoading: Binding(
            get: {self.states.isLoading},
            set: {self.states.isLoading = $0}),
        igAccount: Binding(
            get: {self.states.igAccount},
            set: {self.states.igAccount = $0})
    )}
    
    init(changesCallback: @escaping (Board) -> ()) {
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
    
    func loadUserData() {
        self.states.isLoading.toggle()
        getAllBoards()
    }
    
    func getAllBoards() {
        guard let user = AuthService.current.user else {
            self.states.isLoading.toggle()
            self.states.errorAlertIsShowing.toggle()
            self.states.errorMessage = "No user Logged In"
            return
        }
        //let user = User(uid: "2F361KHcKpNBMLuqLT2CLrtnp3k1", email: "dasda", name: "dasda")
        
        let currentBoard = LocalRepository.shared.getCurrentBoard()
        
        BoardsRepository.current.getAllBoards(of: user) { [weak self] result in
            switch result {
            case.failure(let message):
                if let self = self {
                    self.states.isLoading.toggle()
                    self.states.errorAlertIsShowing.toggle()
                    self.states.errorMessage = message.localizedDescription
                    self.board = Board.init(
                        uid: "",
                        imagePath: "",
                        title: "Plani Board",
                        description: "",
                        instagramAccount: "",
                        ownerUid: user.uid,
                        colaboratorsUids: [],
                        postsGridUid: "",
                        ideasGridUid: "",
                        moodGridUid: "")
                    LocalRepository.shared.saveCurrent(board: self.board)
                }
            case .success(let boardsList):
                if let self = self {
                    if currentBoard != nil {
                        self.board = currentBoard!
                    } else {
                        self.board = boardsList.first ?? Board.init(
                            uid: "",
                            imagePath: "",
                            title: "Plani Board",
                            description: "",
                            instagramAccount: "",
                            ownerUid: user.uid,
                            colaboratorsUids: [],
                            postsGridUid: "",
                            ideasGridUid: "",
                            moodGridUid: "")
                        LocalRepository.shared.saveCurrent(board: self.board)
                    }
                    self.boards = boardsList
                    self.getAllPosts()
                }
            }
            self?.states.igAccount = self?.board.instagramAccount ?? ""
        }
    }
    
    func getAllPosts() {
        //self.states.isLoading.toggle()
        BoardsRepository.current.getAllItens(of: board, on: .posts,ofItemType: Post.self) { result in
            self.states.isLoading.toggle()
            switch result {
            case .failure(let message):
                self.states.isLoading.toggle()
                self.states.errorAlertIsShowing.toggle()
                self.states.errorMessage = message.localizedDescription
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
