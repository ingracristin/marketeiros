//
//  EditBoardView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 13/07/21.
//


import Foundation
import SwiftUI

class EditBoardViewModel : ObservableObject {
    @Published private(set) var states = States()
    var board: Board
    var pastPhoto: UIImage!
    var callback: (Board) -> ()

    init(board: Board, callback: @escaping (Board) -> ()) {
        self.callback = callback
        self.board = board
        states.title = board.title
        states.description = board.description
        states.instragramAccount = board.instagramAccount
        states.photoPath = board.imagePath
        
        ImagesRepository.current.getImage(of: board) { result in
            switch result {
            case .failure(let message):
                print(message)
            case .success(let newImage):
                self.states.inputImage = newImage
                self.pastPhoto = newImage
            }
        }
    }
    
    struct States {
        var title: String = ""
        var description: String = ""
        var instragramAccount = ""
        var photoPath: String = ""
        var inputImage: UIImage?
        var alertViewShowing = false
        var showingImagePicker = false
        var percentage: Float = 0
    }
    
    var bindings: (
        title: Binding<String>,
        description: Binding<String>,
        photoPath: Binding<String>,
        inputImage: Binding<UIImage?>,
        alertViewShowing: Binding<Bool>,
        instragramAccount: Binding<String>,
        showingImagePicker: Binding<Bool>,
        percentage: Binding<Float>)
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
            set: {self.states.showingImagePicker = $0}),
        percentage: Binding(
            get: {self.states.percentage},
            set: {self.states.percentage = $0})
        )}
    
    func toggleImagePicker() {
        
        states.showingImagePicker.toggle()
    }
    
    func saveChangesToBoard(completionHadler: @escaping (String?) -> ()) {
        board.title = states.title
        board.description = states.description
        board.instagramAccount = states.instragramAccount.replacingOccurrences(of: " ", with: "") 
        board.imagePath = board.imagePath
        
        BoardsRepository.current.update(board: board) { [weak self] _ in
            guard let self = self else {return}
            if self.states.inputImage != self.pastPhoto {
                guard let image = self.states.inputImage?.jpeg(.medium) else {return}
                ImagesRepository.current.deleteImage(of: self.board) { _ in}
                
                self.states.alertViewShowing.toggle()
                ImagesRepository.current.upload(imageData: image, of: &self.board) { [weak self] progress in
                    self?.states.percentage = Float(progress)
                } completion: { [weak self] result in
                    self?.states.alertViewShowing.toggle()
                    switch result {
                    case.failure(let message):
                        completionHadler(message.localizedDescription)
                    case .success(_):
                        if let self = self {
                            self.callback(self.board)
                            completionHadler(nil)
                        }
                    }
                }
            } else {
                self.callback(self.board)
                completionHadler(nil)
            }
        }
    }
}
