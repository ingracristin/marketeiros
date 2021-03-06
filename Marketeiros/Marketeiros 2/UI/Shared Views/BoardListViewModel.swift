//
//  BoardViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 29/06/21.
//

import Foundation
import SwiftUI

class BoardListViewModel: ObservableObject {
    @Published var boards = [Board]()
    @Published private(set) var states = States()
    
    struct States {
        var newBoardIsShowing = false
        var newIdeaIsShowing = false
        var boards = [Board]()
    }
    
    var bindings : (
        newBoardIsShowing: Binding<Bool>,
        boards: Binding<[Board]>,
        newIdeaIsShowing: Binding<Bool>
    ) {(
        newBoardIsShowing: Binding(
            get: {self.states.newBoardIsShowing},
            set: {self.states.newBoardIsShowing = $0}),
        boards: Binding(
            get: {self.states.boards},
            set: {self.states.boards = $0}),
        newIdeaIsShowing: Binding(
            get: {self.states.newIdeaIsShowing},
            set: {self.states.newIdeaIsShowing = $0})
    )}
    
    func getAllBoards() {
        guard let user = AuthService.current.user else {return}
        //let user = User(uid: "2F361KHcKpNBMLuqLT2CLrtnp3k1", email: "dasda", name: "dasda")
        
        BoardsRepository.current.getAllBoards(of: user) { [weak self] result in
            switch result {
            case.failure(let message):
                print(message) // é bom botar essa message pra aparece num alert
            case .success(let boardsList):
                if let self = self {
                    self.boards = boardsList
                }
            }
        }
    }
    
    func toggleSheetView () {
        bindings.newBoardIsShowing.wrappedValue.toggle()
    }
    
    func add(board: Board) {
        boards.append(board)
    }
    
    // acho que não vai dar pra ouvir os listener, já que o self das views geralmente é destruído pra se reconstruir de novo
    // pode ser que antes da função de listener executar eu possa fazer um test em self, se ele for nil a função n faz nada, senão ele segue o rumo dele normal, pode ser hein. hmmmmmm
//    func addListenerOnBoards() {
//        BoardsRepository.current.setListener(on: boar, of: <#T##User#>, completion: <#T##(Result<[Board], BoardsRepository.BoardsRepositoryErrors>) -> ()#>) { [weak self] result in
//            switch result {
//            case.failure(let message):
//                print(message) // é bom botar essa message pra aparece num alert
//            case .success(let boardsList):
//                self!.boards = boardsList
//            }
//        }
//    }
//
}
