//
//  EditIdeaViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 12/07/21.
//

import Foundation
import SwiftUI

class EditIdeaViewModel: ObservableObject {
    @Published private(set) var states = States()
    var paste: Paste
    var idea: Idea
    var board: Board
    
    init(board: Board, paste: Paste, idea: Idea) {
        self.idea = idea
        self.paste = paste
        self.board = board
        self.states.title = idea.title
        self.states.description = idea.description
        self.states.paste = paste
    }
    
    struct States {
        var title = ""
        var description = "Descrição"
        var paste: Paste!
        var pasteSheetShowing = false
    }
    
    var bindings: (
        title: Binding<String>,
        description: Binding<String>,
        paste: Binding<Paste>,
        pasteSheetShowing: Binding<Bool>
    ) {(
        title: Binding(
            get: {self.states.title},
            set: {self.states.title = $0}),
        description: Binding(
            get: {self.states.description},
            set: {self.states.description = $0}),
        paste: Binding(
            get: {self.states.paste},
            set: {self.states.paste = $0}),
        pasteSheetShowing: Binding(
            get: {self.states.pasteSheetShowing},
            set: {self.states.pasteSheetShowing = $0})
    )}
    
    func select(paste: Paste) {
        states.paste = paste
    }
    
    func deleteIdea() {
        BoardsRepository.current.delete(item: idea, to: board, on: .ideas) { _ in
            
        }
    }
    
    func updateIdea() {
        idea.title = states.title
        idea.description = states.description
        
        BoardsRepository.current.update(item: &idea, to: board, on: .ideas)
    }

    func togglePasteSheet() {
        states.pasteSheetShowing.toggle()
    }
}
