
//
//  ViewModel.swift
//  instagramScrap
//
//  Created by Gonzalo Ivan Santos Portales on 22/06/21.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var imagesUrls : [ImageUrl] = []
    let igUser: String
    
    init(igUser: String) {
        self.igUser = igUser
    }
}
struct ImageUrl {
    var id = UUID()
    var imageUrl: String
}

