//
//  Post.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation
import FirebaseFirestore

struct Post: Codable, BoardItemSavable, Equatable {
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

struct Paste: Codable, BoardItemSavable{
    var uid: String
    var title: String
    var icon: String
    
    func toJson() -> [String:Any] {
        return [
            "uid": self.uid,
            "icon": self.icon,
            "title": self.title,
        ]
    }
    
    static func from(json: [String: Any]) -> Paste {
        return Paste(
            uid: json["uid"] as? String ?? "",
            title: json["title"] as? String ?? "",
            icon: json["icon"] as? String ?? "")
    }
}

struct Idea: Codable, BoardItemSavable {
    var uid: String
    var icon: String
    var tag: String
    var pasteUid: String = "none"
    var title: String
    var description: String
    
    func toJson() -> [String:Any] {
        return [
            "uid": self.uid,
            "icon": self.icon,
            "title": self.title,
            "description": self.description,
            "tag": self.tag,
            "pasteUid": self.pasteUid
        ]
    }
    
    static func from(json: [String: Any]) -> Idea {
        return Idea(
            uid: json["uid"] as? String ?? "",
            icon: json["icon"] as? String ?? "",
            tag: json["tag"] as? String ?? "",
            pasteUid: json["pasteUid"] as? String ?? "none",
            title: json["title"] as? String ?? "",
            description: json["description"] as? String ?? "")
    }
}

struct MoodBoardImage: Codable, BoardItemSavable {
    var uid: String
    var imagePath: String
    
    func toJson() -> [String:Any] {
        return [
            "uid": self.uid,
            "imagePath": self.imagePath
        ]
    }
    
    static func from(json: [String: Any]) -> MoodBoardImage {
        return MoodBoardImage(
            uid: json["uid"] as? String ?? "",
            imagePath: json["imagePath"] as? String ?? "")
    }
}
