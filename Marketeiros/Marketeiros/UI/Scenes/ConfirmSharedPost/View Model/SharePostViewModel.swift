//
//  SharePostView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 05/08/21.
//

import Foundation
import UIKit
import SwiftUI

class SharePostViewModel: ObservableObject {
    func getImage(of scheduledPost: ScheduledNotification?) -> UIImage {
        if let post = scheduledPost {
            return ImagesRepository.current.getImageOfScheduledPost(withUid: post.uid, ofBoardWithUid: post.boardUid)
        }
        return UIImage(named:"TestImage")!
    }
    
    func share(scheduledPost: ScheduledNotification?) {
        if let post = scheduledPost {
            SocialNetworkService.shared.open(socialNetwork: .instagram, andSend: post.toJson())
        }
    }
}
