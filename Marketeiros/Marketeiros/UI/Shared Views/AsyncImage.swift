//
//  AsyncImage.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 22/06/21.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    var averageColorOn: Binding<Bool>
    var height: CGFloat
    var width: CGFloat
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        averageColorOn: Binding<Bool>,
        height : CGFloat,
        width: CGFloat,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        self.averageColorOn = averageColorOn
        self.height = height
        self.width = width
        _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let img = loader.image {
                ZStack(alignment: .topTrailing){
                    image(img)
                    Rectangle()
                            .foregroundColor(Color(img.averageColor ?? .clear))
                            .opacity(0.85).isHidden(!averageColorOn.wrappedValue)
                    ZStack(alignment:.center){
                        Rectangle()
                            .frame(width: self.width * 0.3982, height:  self.height * 0.0973)
                            .foregroundColor(Color(#colorLiteral(red: 0.537254902, green: 0.5411764706, blue: 0.5529411765, alpha: 0.5)))
                            .cornerRadius(3)
                            .shadow(radius: 6, x: 2, y: 4)
                        Text(NSLocalizedString("posted", comment: ""))
                            .font(.custom("SF Pro Display", size: 8))
                            .fontWeight(.regular)
                            .foregroundColor(.white)
                    }.padding(.init(top: 8, leading: 0, bottom: 0, trailing: 5))
                 }
            } else {
                placeholder
            }
        }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var isLoading = false
    
    private let url: URL
    private var cache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !isLoading else { return }

        if let image = cache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveOutput: { [weak self] in self?.cache($0) },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func onStart() {
        isLoading = true
    }
    
    private func onFinish() {
        isLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }
}

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
