
//  User.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation

struct User {
    var uid : String
    var email : String
    var name : String
    
    init(uid: String, email: String, name: String) {
        self.uid = uid
        self.email = email
        self.name = name
    }
    
    func toJson() -> [String : Any] {
        return [
            "uid": self.uid,
            "email": self.email,
            "name": self.name,
        ]
    }
}
