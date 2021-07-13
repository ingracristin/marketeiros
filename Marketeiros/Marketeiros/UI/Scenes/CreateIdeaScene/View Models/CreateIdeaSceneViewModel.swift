//
//  IdeaSceneViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 07/07/21.
//

import Foundation
import SwiftUI

class CreateIdeaSceneViewModel: ObservableObject {
    @Published private(set) var states = States()
    var pastes: [Paste]
    var board: Board
    
    init(board: Board, pastes: [Paste]) {
        self.pastes = pastes
        self.board = board
        self.states.paste = (pastes.count == 1) ? pastes.first : Paste(uid: "none", title: "none", icon: "none")
    }
    
    struct States {
        var title = ""
        var description = NSLocalizedString("descriptionIdea", comment: "")
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
    
    func setDescriptionwith(text: String) {
        states.description = text
    }
    
    func select(paste: Paste) {
        states.paste = paste
    }
    
    func setNonePaste() {
        states.paste = Paste(uid: "none", title: "none", icon: "none")
    }
    
    func saveIdea(completion: ((Idea) -> ())?) {
        var idea = Idea(
            uid: "",
            icon: "",
            tag: states.paste.title,
            pasteUid: states.paste.uid,
            title: states.title,
            description: states.description)
        
        completion?(idea)
        BoardsRepository.current.add(item: &idea, to: board, on: .ideas)
    }

    func togglePasteSheet() {
        states.pasteSheetShowing.toggle()
    }
}
