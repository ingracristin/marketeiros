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
    var averageColorOn: Binding<Bool>
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    private let width: CGFloat
    private let height: CGFloat
    
    init(
        post: Post,
        board: Board,
        widthImg: CGFloat,
        heightImg: CGFloat,
        averageColorOn: Binding<Bool>,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image
    ) {
        self.averageColorOn = averageColorOn
        self.placeholder = placeholder()
        self.image = image
        self.imageLoader = Loader(post: post, board: board, cache: Environment(\.imageCache).wrappedValue)
        self.width = widthImg
        self.height = heightImg
    
    }
    
    init(
        board: Board,
        averageColorOn: Binding<Bool>,
        widthImg: CGFloat,
        heightImg: CGFloat,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        self.imageLoader = Loader(board: board)
        self.averageColorOn = averageColorOn
        self.width = widthImg
        self.height = heightImg
    }
    
    var body: some View {
        if let image = imageLoader.image {
            ZStack {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: self.width, height: self.height, alignment: .center)
                    .clipped()
                Rectangle()
                        .foregroundColor(Color(image.averageColor ?? .clear))
                        .opacity(0.85).isHidden(!averageColorOn.wrappedValue)
            }
        } else {
            placeholder
                .frame(width: self.width, height: self.height, alignment: .center)
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
                    if let self = self {
                        self.image = newImage
                        self.uid = post.uid
                    }
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
                    if let self = self {
                        self.image = newImage
                        self.uid = board.uid
                    }
                }
            }
        }
    }
}
