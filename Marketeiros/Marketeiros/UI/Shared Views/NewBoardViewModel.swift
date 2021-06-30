//
//  NewBoardViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 29/06/21.
//

import Foundation
import SwiftUI

class NewBoardViewModel : ObservableObject {
    @Published private(set) var states = States()
    var callback: (Board) -> ()

    init(callback: @escaping (Board) -> ()) {
        self.callback = callback
    }
    
    struct States {
        var title: String = ""
        var description: String = ""
        var photoPath: String = ""
        var inputImage: UIImage?
    }
    
    var bindings: (
        title: Binding<String>,
        description: Binding<String>,
        photoPath: Binding<String>,
        inputImage: Binding<UIImage?>)
    {(
        title: Binding(
            get: {self.states.title},
            set: {self.states.title = $0}),
        description: Binding(
            get: {self.states.description},
            set: {self.states.description = $0}),
        photoPath: Binding(
            get: {self.states.photoPath},
            set: {self.states.photoPath = $0}),
        inputImage: Binding(
            get: {self.states.inputImage},
            set: {self.states.inputImage = $0})
        )}
    
    func createBoard() {
        guard let user = AuthService.current.user else {return}
        var board = Board(
            uid: "",
            imagePath: "",
            title: states.title,
            description: states.description,
            instagramAccount: "",
            ownerUid: user.uid,
            colaboratorsUids: [""],
            postsGridUid: "",
            ideasGridUid: "",
            moodGridUid: "")
        
        let newBoard = BoardsRepository.current.create(board: &board)
        callback(newBoard)
    }
}
