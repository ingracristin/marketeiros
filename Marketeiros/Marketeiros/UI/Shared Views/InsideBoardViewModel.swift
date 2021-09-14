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
    @Published var states = States()
    var changesCallback: (Board) -> ()
    
    var screenNavTitle: String {
        let title = self.states.board.instagramAccount.removeCharactersContained(in: "@")
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
        var boards = [Board]()
        var board: Board = Board.init(
            uid: "",
            imagePath: "",
            title: "",
            description: "",
            instagramAccount: "",
            ownerUid: AuthService.current.user?.uid ?? "",
            colaboratorsUids: [],
            postsGridUid: "",
            ideasGridUid: "",
            moodGridUid: "")
        var imagesUrls = [ImageUrl]()
        var emptyProfile = false
    }
    
    var bindings: (
        selectedIndex: Binding<Int>,
        addPostScreenShowing: Binding<Bool>,
        editBoardIsShowing: Binding<Bool>,
        errorAlertIsShowing: Binding<Bool>,
        errorMessage: Binding<String>,
        isLoading: Binding<Bool>,
        igAccount: Binding<String>,
        boards: Binding<[Board]>,
        board: Binding<Board>,
        imagesUrls: Binding<[ImageUrl]>,
        emptyProfile: Binding<Bool>)
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
            set: {self.states.igAccount = $0}),
        boards: Binding(
            get: {self.states.boards},
            set: {self.states.boards = $0}),
        board: Binding(
            get: {self.states.board},
            set: {
                self.states.board = $0
                self.getAllPosts()
            }),
        imagesUrls: Binding(
            get: {self.states.imagesUrls},
            set: {self.states.imagesUrls = $0}),
        emptyProfile: Binding(
            get: {self.states.emptyProfile},
            set: {self.states.emptyProfile = $0})
    )}
    
    init(changesCallback: @escaping (Board) -> ()) {
        self.changesCallback = changesCallback
    }
    
    func change(board: Board) {
        self.bindings.board.wrappedValue = board
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
        if self.states.selectedIndex == 0 {
            self.states.isLoading = true
        }

        getAllBoards()
    }
    
    func getAllBoards() {
        guard let user = AuthService.current.user else {
            self.states.isLoading = false
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
                    self.states.isLoading = false
                    self.states.errorAlertIsShowing.toggle()
                    self.states.errorMessage = message.localizedDescription
                    self.states.board = Board.init(
                        uid: "",
                        imagePath: "",
                        title: "Empty Profile",
                        description: "",
                        instagramAccount: "",
                        ownerUid: user.uid,
                        colaboratorsUids: [],
                        postsGridUid: "",
                        ideasGridUid: "",
                        moodGridUid: "")
                    LocalRepository.shared.saveCurrent(board: self.states.board)
                }
            case .success(let boardsList):
                if let self = self {
                    if currentBoard != nil {
                        self.states.board = currentBoard!
                    } else {
                        self.states.board = boardsList.first ?? Board.init(
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
                        LocalRepository.shared.saveCurrent(board: self.states.board)
                    }
                    self.states.boards = boardsList
                    self.getAllPosts()
                }
            }
            self?.states.igAccount = self?.states.board.instagramAccount ?? ""
        }
    }
    
    func getAllPosts() {
        if !states.isLoading && states.selectedIndex == 0 {
            states.isLoading.toggle()
        }
        LocalRepository.shared.saveCurrent(board: self.states.board)
        self.states.igAccount = self.states.board.instagramAccount
        self.states.imagesUrls = ImagesLocalRepository.shared.getImagesUrls(from: "instagramUrlsFrom=\(self.states.board.instagramAccount)").map({ImageUrl(imageUrl: $0)})
        BoardsRepository.current.getAllItens(of: self.states.board, on: .posts,ofItemType: Post.self) { result in
            self.states.isLoading = false
            switch result {
            case .failure(let message):
                self.states.errorAlertIsShowing.toggle()
                self.states.errorMessage = message.localizedDescription
            case .success(let postsList):
                self.posts = postsList
                if postsList.isEmpty && self.states.board.instagramAccount.isEmpty {
                    self.states.emptyProfile = true
                } else {
                    self.states.emptyProfile = false
                }
            }
        }
    }
    
    func delete(board: Board, completion: @escaping (Bool) -> ()) {
        if board.uid == states.board.uid {
            let uids = posts.map {$0.uid}
            deleteSelected(board: board, andPostsWith: uids, completion: completion)
            
            if let randomBoard = self.states.boards.randomElement() {
                self.bindings.board.wrappedValue = randomBoard
            } else {
                self.bindings.board.wrappedValue = Board.init(
                    uid: "",
                    imagePath: "",
                    title: "Empty Profile",
                    description: "",
                    instagramAccount: "",
                    ownerUid: AuthService.current.user?.uid ?? "",
                    colaboratorsUids: [],
                    postsGridUid: "",
                    ideasGridUid: "",
                    moodGridUid: "")
            }
        } else {
            BoardsRepository.current.getAllItens(of: board, on: .posts, ofItemType: Post.self) { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(false)
                case .success(let deletePosts):
                    let uids = deletePosts.map {$0.uid}
                    self.deleteSelected(board: board, andPostsWith: uids, completion: completion)
                }
            }
        }
    }
    
    private func deleteSelected(board: Board, andPostsWith uids: [String], completion: @escaping (Bool) -> ()) {
        UserNotificationService.shared.deleteNotificationWith(uids: uids)
        BoardsRepository.current.delete(board: board) { result in
            switch result {
            case .failure(_):
                completion(false)
            case .success(_):
                completion(true)
            }
        }
        self.states.boards.removeAll {$0.uid == board.uid}
    }
}
