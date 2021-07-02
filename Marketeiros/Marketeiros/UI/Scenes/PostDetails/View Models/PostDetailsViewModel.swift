//
//  PostDetailsViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/07/21.
//

import Foundation
import SwiftUI

class PostDetailsViewModel: ObservableObject {
    @Published private(set) var states = States()
    var post: Post
    var board: Board
    
    struct States {
        var titlePost = ""
        var legendPost = ""
        var hashtag = ""
        var markedAccountsOnPost = ""
        var scheduleDate = Date()
        var showGreeting = false
        var showingImagePicker = false
        var showingAlertView = false
        var image: Image?
        var imagePath: String = ""
        var inputImage: UIImage?
        var percentage: Double = 0
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
        percentage: Binding<Double>)
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
            get: {self.states.showGreeting},
            set: {self.states.showGreeting = $0}),
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
    
    init(post: Post, board: Board) {
        self.post = post
        self.board = board
        states.titlePost = post.title
        states.legendPost = post.description
        states.markedAccountsOnPost = post.markedAccountsOnPost.first ?? ""
        states.hashtag = post.hashtags.first ?? ""
        
        ImagesRepository.current.getImage(of: post, ofBoard: board) { result in
            switch result {
            case .failure(let message):
                print("")
            case .success(let newImage):
                self.states.inputImage = newImage
            }
        }
    }
    
    func saveChangesToPost(completionHadler: @escaping (String?) -> ()) {
//        guard let image = states.inputImage?.jpeg(.high) else {return}
//
//        var post = Post(
//            uid: "",
//            photoPath: states.imagePath,
//            title: states.titlePost,
//            description: states.legendPost,
//            hashtags: [states.hashtag],
//            markedAccountsOnPost: [states.markedAccountsOnPost],
//            dateOfPublishing: states.scheduleDate)
//
//        BoardsRepository.current.add(item: &post, to: board, on: .posts)
//
//        UserNotificationService.shared.setUserNotification(on: post.dateOfPublishing, withData: [
//            "imagePath": post.photoPath,
//            "description": post.description,
//            "uid": post.uid
//        ])
//
//        states.showingAlertView.toggle()
//        ImagesRepository.current.upload(imageData: image, of: post, ofBoard: board) {[weak self] percentage in
//            print(percentage)
//            self?.states.percentage = percentage
//        } completion: { result in
//            switch result {
//            case .failure(let message):
//                completionHadler(message.localizedDescription)
//            case .success(_):
//                completionHadler(nil)
//            }
//            self.states.showingAlertView.toggle()
//        }
    }
    
    func loadImage() {
        guard let inputImage = states.inputImage else { return }
        states.image = Image(uiImage: inputImage)
    }
    
    func toggleImagePicker() {
        states.showingImagePicker.toggle()
    }
}
