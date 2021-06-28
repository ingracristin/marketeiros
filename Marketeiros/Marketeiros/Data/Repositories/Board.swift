//
//  Board.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 24/06/21.
//

import Foundation

struct Board: Codable {
    var uid: String
    var title: String
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
            title: json["title"] as! String,
            instagramAccount: json["instagramAccount"] as! String,
            ownerUid: json["ownerUid"] as! String,
            colaboratorsUids: json["colaboratorsUids"] as! [String],
            postsGridUid: json["postsGridUid"] as! String,
            ideasGridUid: json["ideasGridUid"] as! String,
            moodGridUid: json["moodGridUid"] as! String)
    }
}
