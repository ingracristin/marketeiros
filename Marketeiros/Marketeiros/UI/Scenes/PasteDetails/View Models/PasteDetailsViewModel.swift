//
//  PasteDetailsViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 08/07/21.
//

import Foundation
import SwiftUI

class PasteDetailsViewModel: ObservableObject {
    @Published var states = States()
    @Published var paste: Paste
    @Published var ideas: [Idea]
    var board: Board
    
    init(paste: Paste, board: Board, ideas: [Idea]) {
        self.paste = paste
        self.board = board
        self.ideas = ideas
    }
    
    struct States {
        var ideas = [Idea]()
        var sheetViewIsAppearing = false
    }
    
    var bindings: (
        ideas: Binding<[Idea]>,
        sheetViewIsAppearing: Binding<Bool>
    ) {(
        ideas: Binding(
            get: {self.states.ideas},
            set: {self.states.ideas = $0}),
        sheetViewIsAppearing: Binding(
            get: {self.states.sheetViewIsAppearing},
            set: {self.states.sheetViewIsAppearing = $0})
    )}
    
    func toggleSheet() {
        states.sheetViewIsAppearing.toggle()
    }
    
    func deletePaste(completion: @escaping (Bool) -> ()) {
        let uid = paste.uid
        let b = board
        BoardsRepository.current.delete(item: paste, to: board, on: .pastes) { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(_):
            BoardsRepository.current.deleteQueryWhere(field: "pasteUid", equals: [uid], on: .ideas, of: b, ofItemType: Idea.self) { result in
                    switch result {
                    case .failure(let error):
                        print(error)
                    case .success(_):
                        completion(true)
                    }
                }
            }
        }
    }
    
    func set(paste: Paste) {
        self.paste = paste
    }
    
    func updatePaste() {
        BoardsRepository.current.update(item: &paste, to: board, on: .pastes)
    }
}
