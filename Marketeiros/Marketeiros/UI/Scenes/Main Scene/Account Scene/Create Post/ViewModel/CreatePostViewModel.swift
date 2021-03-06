//
//  CreatePostViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 28/06/21.
//

import Foundation
import SwiftUI

class CreatePostViewModel : ObservableObject {
    @Published private(set) var states = States()
    var board : Board
    
    struct States {
        var titlePost = ""
        var legendPost = NSLocalizedString("PH_caption", comment: "")
        var hashtag = ""
        var markedAccountsOnPost = ""
        var scheduleDate = Date()
        var isShowingDatePicker = false
        var showingImagePicker = false
        var showingAlertView = false
        var image: Image?
        var imagePath: String = ""
        var inputImage: UIImage?
        var percentage: Float = 0
    }
    
    var bindings: (
        titlePost: Binding<String>,
        legendPost: Binding<String>,
        hastagPost: Binding<String>,
        markedPost: Binding<String>,
        scheduleDate: Binding<Date>,
        showGreeting: Binding<Bool>,
        image: Binding<Image?>,
        showingImagePicker: Binding<Bool>,
        inputImage: Binding<UIImage?>,
        imagePath: Binding<String>,
        showingAlertView: Binding<Bool>,
        percentage: Binding<Float>)
    {(
        titlePost: Binding(
            get: {self.states.titlePost},
            set: {self.states.titlePost = $0}),
        legendPost: Binding(
            get: {self.states.legendPost},
            set: {self.states.legendPost = $0}),
        hastagPost: Binding(
            get: {self.states.hashtag},
            set: {self.states.hashtag = $0}),
        markedPost: Binding(
            get: {self.states.markedAccountsOnPost},
            set: {self.states.markedAccountsOnPost = $0}),
        scheduleDate: Binding(
            get: {self.states.scheduleDate},
            set: {self.states.scheduleDate = $0}),
        showGreeting: Binding(
            get: {self.states.isShowingDatePicker},
            set: {self.states.isShowingDatePicker = $0}),
        image: Binding(
            get: {self.states.image},
            set: {self.states.image = $0}),
        showingImagePicker: Binding(
            get: {self.states.showingImagePicker},
            set: {self.states.showingImagePicker = $0}),
        inputImage: Binding(
            get: {self.states.inputImage},
            set: {self.states.inputImage = $0}),
        imagePath: Binding(
            get: {self.states.imagePath},
            set: {self.states.imagePath = $0}),
        showingAlertView: Binding(
            get: {self.states.showingAlertView},
            set: {self.states.showingAlertView = $0}),
        percentage: Binding(
            get: {self.states.percentage},
            set: {self.states.percentage = $0})
    )}
    
    init(board: Board) {
        self.board = board
    }
    
    func addPostToBoard(completionHadler: @escaping (String?) -> ()) {
        guard let image = states.inputImage?.jpeg(.medium) else {return}
        
        var post = Post(
            uid: "",
            photoPath: states.imagePath,
            title: states.titlePost,
            description: states.legendPost,
            hashtags: [states.hashtag],
            markedAccountsOnPost: [states.markedAccountsOnPost],
            dateOfPublishing: (states.isShowingDatePicker) ? states.scheduleDate : nil)
        
        BoardsRepository.current.add(item: &post, to: board, on: .posts)
        
        if states.isShowingDatePicker {
            UserNotificationService.shared.setUserNotification(on: post.dateOfPublishing!, withData: [
                "title": post.title,
                "imagePath": post.photoPath,
                "uid": post.uid,
                "description": post.hashtags.isEmpty ? post.description: "\(post.description) \n\(post.hashtags.first!)",
                "boardUid": board.uid,
                "boardTitle": board.title,
            ])
        }
        
        states.showingAlertView.toggle()
        ImagesRepository.current.upload(imageData: image, of: post, ofBoard: board) {[weak self] percentage in
            print(percentage)
            self?.states.percentage = Float(percentage)
        } completion: { result in
            switch result {
            case .failure(let message):
                completionHadler(message.localizedDescription)
            case .success(_):
                completionHadler(nil)
            }
            self.states.showingAlertView.toggle()
        }
    }
    
    func publishNow() {
        SocialNetworkService.shared.open(socialNetwork: .instagram, andSend: ["imagePath": states.imagePath, "description": states.legendPost])
    }
    
    func requestUserNotification() {
        UserNotificationService.shared.askUserNotificationPermission()
    }
    
    func loadImage() {
        guard let inputImage = states.inputImage else { return }
        states.image = Image(uiImage: inputImage)
    }
    
    func toggleImagePicker() {
        states.showingImagePicker.toggle()
    }
}
