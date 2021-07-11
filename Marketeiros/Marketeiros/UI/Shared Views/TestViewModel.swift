
//
//  ViewModel.swift
//  instagramScrap
//
//  Created by Gonzalo Ivan Santos Portales on 22/06/21.
//

import Foundation

class ViewModel : ObservableObject {
    @Published var imagesUrls : [String] = []
    let igUser: String
    
    init(igUser: String) {
        self.igUser = igUser
    }
}

