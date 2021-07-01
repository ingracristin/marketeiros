//
//  Post.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation
import FirebaseFirestore

struct Post: Codable, BoardItemSavable {
    var uid: String
    var photoPath: String
    var title: String
    var description: String
    var hashtags: [String]
    var markedAccountsOnPost: [String]
    var dateOfPublishing: Date
    
    func toJson() -> [String:Any] {
        return [
            "uid": self.uid,
            "photoPath": self.photoPath,
            "title": self.title,
            "description": self.description,
            "hashtags": self.hashtags,
            "markedAccountsOnPost": self.markedAccountsOnPost,
            "dateOfPublishing": self.dateOfPublishing
        ]
    }
    
    static func from(json: [String: Any]) -> Post {
        let firebaseDate = json["dateOfPublishing"] as! Timestamp
        let date = Date(timeIntervalSince1970: TimeInterval(firebaseDate.seconds))
        
        return Post(
            uid: json["uid"] as? String ?? "",
            photoPath: json["photoPath"] as? String ?? "",
            title: json["title"] as? String ?? "",
            description: json["description"] as? String ?? "",
            hashtags: json["hashtags"] as? [String] ?? [""],
            markedAccountsOnPost: json["markedAccountsOnPost"] as? [String] ?? [""],
            dateOfPublishing: date)
    }
}

struct Paste: Codable {
    var uid: String
    var title: String
    var icon: String
    var ideas: [Idea]
}

struct Idea: Codable {
    var uid: String
    var tag: String
    var title: String
    var description: String
}

struct IdeaImage: Codable {
    var uid: String
    var imagePath: String
}
