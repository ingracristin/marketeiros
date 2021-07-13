
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
            "email": self.email ?? "unknown@mail.com",
            "name": self.name ?? "",
        ]
    }
}

struct UserProfile {
    var uid: String
    var email: String
    var name: String
    var username: String
    
    static func from(json: [String: Any])  -> UserProfile {
        return UserProfile(
            uid: json["uid"] as! String,
            email: json["email"] as! String,
            name: json["name"] as! String,
            username: json["username"] as! String)
    }
    
    func toJson() -> [String : Any] {
        return [
            "uid": self.uid,
            "email": self.email ?? "unknown@mail.com",
            "name": self.name ?? "",
            "username": self.username
        ]
    }
}
