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
        var instragramAccount = ""
        var photoPath: String = ""
        var inputImage: UIImage?
        var alertViewShowing = false
        var showingImagePicker = false
    }
    
    var bindings: (
        title: Binding<String>,
        description: Binding<String>,
        photoPath: Binding<String>,
        inputImage: Binding<UIImage?>,
        alertViewShowing: Binding<Bool>,
        instragramAccount: Binding<String>,
        showingImagePicker: Binding<Bool>)
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
            set: {self.states.inputImage = $0}),
        alertViewShowing: Binding(
            get: {self.states.alertViewShowing},
            set: {self.states.alertViewShowing = $0}),
        instragramAccount: Binding(
            get: {self.states.instragramAccount},
            set: {self.states.instragramAccount = $0}),
        showingImagePicker: Binding(
            get: {self.states.showingImagePicker},
            set: {self.states.showingImagePicker = $0})
        )}
    
    func toggleImagePicker() {
        states.showingImagePicker.toggle()
    }
    
    func createBoard() {
        guard let user = AuthService.current.user else {return}
        guard let image = states.inputImage?.jpeg(.high) else {return}
        
        var board = Board(
            uid: " ",
            imagePath: " ",
            title: states.title,
            description: states.description,
            instagramAccount: states.instragramAccount,
            ownerUid: user.uid,
            colaboratorsUids: [" "],
            postsGridUid: " ",
            ideasGridUid: " ",
            moodGridUid: " ")
        
        BoardsRepository.current.create(board: &board) { result in
            switch result {
            case.failure(let message):
                print(message)
            case .success(_):
                ImagesRepository.current.upload(imageData: image, of: &board) { progress in
                    print(progress)
                } completion: { [weak self] result in
                    switch result {
                    case.failure(let message):
                        print(message)
                    case .success(_):
                        if let self = self {
                            self.callback(board)
                        }
                    }
                }
            }
        }
    }
}
