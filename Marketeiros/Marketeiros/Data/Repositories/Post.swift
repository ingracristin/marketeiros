//
//  Post.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation

struct Post: Codable {
    var photoPath: String
    var description: String
    var hashtags: [String]
    var dateOfPublishing: Date
    
    func toJson() -> [String:Any] {
        return [
            "photoPath": self.photoPath,
            "description": self.description,
            "hashtags": self.hashtags,
            "dateOfPublishing": self.dateOfPublishing
        ]
    }
    
    static func from(json: [String: Any], with date: Date) -> Post {
        return Post(
            photoPath: json["photoPath"] as! String,
            description: json["description"] as! String,
            hashtags: json["hashtags"] as! [String],
            dateOfPublishing: date)
    }
}

struct Paste: Codable {
    var title: String
    var icon: String
    var ideas: [Idea]
}

struct Idea: Codable {
    var tag: String
    var title: String
    var description: String
}

struct IdeaImage: Codable {
    var imagePath: String
}
