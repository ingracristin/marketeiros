//
//  FirebaseImage.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 01/07/21.
//

import Foundation
import Combine
import SwiftUI

struct FirebaseImage<Placeholder: View> : View {
    @ObservedObject private var imageLoader : Loader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        post: Post,
        board: Board,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image
    ) {
        self.placeholder = placeholder()
        self.image = image
        self.imageLoader = Loader(post: post, board: board, cache: Environment(\.imageCache).wrappedValue)
    }
    
    init(
        board: Board,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        self.imageLoader = Loader(board: board)
    }
    
    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .frame(width: 100, height: 100, alignment: .center)
        } else {
            placeholder
        }
    }
}

final class Loader : ObservableObject {
    @Published var image : UIImage?
    var uid: String = ""

    init(post: Post, board: Board, cache: ImageCache) {
        ImagesRepository.current.getImage(of: post, ofBoard: board) {[weak self] result in
            switch result {
            case .failure(_):
                print("")
            case .success(let newImage):
                DispatchQueue.main.async {
                    self!.image = newImage
                    self!.uid = post.uid
                }
            }
        }
    }
    
    init(board: Board) {
        ImagesRepository.current.getImage(of: board) { [weak self] result in
            switch result {
            case .failure(_):
                print("")
            case .success(let newImage):
                DispatchQueue.main.async {
                    self!.image = newImage
                    self!.uid = board.uid
                }
            }
        }
    }
}
