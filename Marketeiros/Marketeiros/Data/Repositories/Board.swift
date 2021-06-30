//
//  Board.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation

protocol BoardItemSavable {
    associatedtype T
    func toJson() -> [String: Any]
    static func from(json: [String: Any]) -> T
}

struct Board: Codable, BoardItemSavable {
    var uid: String
    var imagePath: String
    var title: String
    var description: String
    var instagramAccount: String
    var ownerUid: String
    var colaboratorsUids: [String]
    var postsGridUid: String
    var ideasGridUid: String
    var moodGridUid: String
    
    func toJson() -> [String: Any] {
        return [
            "uid": self.uid,
            "title": self.title,
            "description": self.description,
            "imagePath": self.imagePath,
            "instagramAccount": self.instagramAccount,
            "ownerUid": self.ownerUid,
            "colaboratorsUids": self.colaboratorsUids,
            "postsGridUid": self.postsGridUid,
            "ideasGridUid": self.ideasGridUid,
            "moodGridUid": self.moodGridUid,
        ]
    }
    
    static func from(json: [String: Any]) -> Board {
        return Board(
            uid: json["uid"] as! String,
            imagePath: json["imagePath"] as! String,
            title: json["title"] as! String,
            description: json["description"] as! String,
            instagramAccount: json["instagramAccount"] as! String,
            ownerUid: json["ownerUid"] as! String,
            colaboratorsUids: json["colaboratorsUids"] as! [String],
            postsGridUid: json["postsGridUid"] as! String,
            ideasGridUid: json["ideasGridUid"] as! String,
            moodGridUid: json["moodGridUid"] as! String)
    }
}
