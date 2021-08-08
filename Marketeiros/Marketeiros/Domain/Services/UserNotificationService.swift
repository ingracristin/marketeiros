//
//  UserNotificationService.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 14/06/21.
//

import Foundation
import SwiftUI
import UserNotifications

struct ScheduledNotification {
    var uid: String
    var title: String
    var description: String
    var boardUid: String
    var boardTitle: String
    var date: Date
    var imagePath: String
    
    static func from(json: [String: Any]) -> ScheduledNotification {
        return ScheduledNotification(
            uid: json["uid"] as! String,
            title: json["title"] as! String,
            description: json["description"] as! String,
            boardUid: json["boardUid"] as! String,
            boardTitle: json["boardTitle"] as! String,
            date: json["date"] as? Date ?? .init(),
            imagePath: json["imagePath"] as! String)
    }
    
    func toJson() -> [String: Any] {
        return [
            "uid": self.uid ,
            "title": self.title,
            "description": self.description,
            "boardUid": self.boardUid,
            "boardTitle": self.boardTitle,
            "imagePath": self.imagePath,
            "date": self.date
        ]
    }
}

class UserNotificationService: NSObject,UNUserNotificationCenterDelegate, ObservableObject {
    var notificationCenter : UNUserNotificationCenter
    @Published private(set) var states = States()
    static let shared = UserNotificationService()
    
    struct States {
        var hasNotification = false
        var postScheduledNotification: ScheduledNotification = .init(uid: "", title: "", description: "", boardUid: "", boardTitle: "", date: .init(), imagePath: "")
    }
    
    var bindings: (
        hasNotification: Binding<Bool>,
        scheduledNotification: Binding<ScheduledNotification>
    ) {(
        hasNotification: Binding(
            get: {self.states.hasNotification},
            set: {self.states.hasNotification = $0}),
        scheduledNotification: Binding(
            get: {self.states.postScheduledNotification},
            set: {self.states.postScheduledNotification = $0})
    )}
    
    func setHasNotification(value: Bool) {
        states.hasNotification = value
    }
    
    struct Constants {
        static let appName = "Plani"
        static let notificationSubtitle = NSLocalizedString("timePost", comment: "")
        static let notificationBody = NSLocalizedString("postSchedule", comment: "")
        static let categoryId = "myCategory"
    }
    
    private init(notificationCenter:  UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
        let category = UNNotificationCategory(
            identifier: "myCategory",
            actions: [
                .init(identifier: "Postar", title: NSLocalizedString("post", comment: ""), options: .foreground),
                .init(identifier: "Cancelar", title: NSLocalizedString("cancel", comment: ""), options: .destructive)
            ],
            intentIdentifiers: [],
            options: []
        )
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func setUserNotificationOn(weekDays: [Int], hour: Int,minute : Int) {
        let content = UNMutableNotificationContent()
        content.title = Constants.appName
        content.body = Constants.notificationBody

        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        for weekDay in weekDays {
            dateComponents.weekday = weekDay
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

            let id = UUID().uuidString
            
            let request = UNNotificationRequest(identifier: id,
                         content: content, trigger: trigger)
             
            notificationCenter.add(request) { (error) in
                if error != nil {
                    print(error as Any)
                }
            }
        }
    }
    
    func setUserNotificationIn(minutes: Int) {
        let category = UNNotificationCategory(
            identifier: "myCategory",
            actions: [
                .init(identifier: "Registrar", title: NSLocalizedString("reg", comment: ""), options: .foreground),
            ],
            intentIdentifiers: [],
            options: []
        )
        
        notificationCenter.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = Constants.appName
        content.subtitle = Constants.notificationSubtitle
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "myCategory"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60 * minutes), repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        print(request)
        
        notificationCenter.add(request)
    }
    
    func setUserNotificationIn(minutes: Int, withData dictInfo: [String : Any]) {
        let category = UNNotificationCategory(
            identifier: Constants.categoryId,
            actions: [
                .init(identifier: "Postar", title: NSLocalizedString("post", comment: ""), options: .foreground),
                //.init(identifier: "op2", title: "Opcao 2", options: .destructive)
            ],
            intentIdentifiers: [],
            options: []
        )
        
        notificationCenter.setNotificationCategories([category])
        
        let content = UNMutableNotificationContent()
        content.title = Constants.appName
        content.subtitle = Constants.notificationSubtitle
        content.sound = UNNotificationSound.default
        content.userInfo = dictInfo
        content.categoryIdentifier = Constants.categoryId
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(60 * minutes), repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request)
    }
    
    func setUserNotification(on date: Date, withData dictInfo: [String : Any]) {
        let content = UNMutableNotificationContent()
        content.title = Constants.appName
        content.subtitle = Constants.notificationSubtitle
        content.sound = UNNotificationSound.default
        content.userInfo = dictInfo
        content.categoryIdentifier = Constants.categoryId
        
        let components = Calendar.current.dateComponents([.day,.hour,.month,.minute,.year], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components , repeats: false)
    
        let request = UNNotificationRequest(identifier: dictInfo["uid"] as! String, content: content, trigger: trigger)
        
        notificationCenter.add(request) { erro in
            print(erro?.localizedDescription)
        }
    }
    
    func deleteNotificationWith(uids: [String]) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: uids)
    }
    
    func getNotificationsDaysHourMinute(completion: @escaping ([Int],Int,Int) -> ()) {
        var days : [Int] = []
        var hour : Int = 0
        var minute : Int = 0
        
        notificationCenter.getPendingNotificationRequests(completionHandler: { notifications in
            if !notifications.isEmpty {
                for notification in notifications {
                    let trigger = notification.trigger as! UNCalendarNotificationTrigger
                    days.append(trigger.dateComponents.weekday!)
                    hour = trigger.dateComponents.hour!
                    minute = trigger.dateComponents.minute!
                }
            }

            completion(days,hour,minute)
        })
    }
    
    func getScheduledNotifications(completion: @escaping ([ScheduledNotification]) -> ()) {
        var scheduledNotifications = [ScheduledNotification]()
        
        notificationCenter.getPendingNotificationRequests(completionHandler: { notifications in
            if !notifications.isEmpty {
                for notification in notifications {
                    let content = notification.content.userInfo as! [String : Any]
                    let trigger = notification.trigger as! UNCalendarNotificationTrigger
                    let date = trigger.nextTriggerDate()
                    scheduledNotifications.append(
                        ScheduledNotification(
                            uid: content["uid"] as! String,
                            title: content["title"] as! String,
                            description: content["description"] as! String,
                            boardUid: content["boardUid"] as! String,
                            boardTitle: content["boardTitle"] as! String,
                            date: date!,
                            imagePath: content["imagePath"] as! String))
                }
            }

            completion(scheduledNotifications)
        })
    }
    
    func getPendingNotifications(completion: @escaping ([String]) -> ()) {
        notificationCenter.getPendingNotificationRequests(completionHandler: { notifications in
            var notificationsDescriptions : [String] = []
            for notification in notifications {
                notificationsDescriptions.append(notification.trigger!.description)
            }
            completion(notificationsDescriptions)
        })
    }
    
    func removeAllPendingNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func askUserNotificationPermission() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            print(success)
            if success {
                print("Aceito")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let postData = response.notification.request.content.userInfo as! [String : Any]
        
        if response.actionIdentifier == "Cancelar" {
            completionHandler()
            return
        }
        
        //SocialNetworkService.shared.open(socialNetwork: .instagram, andSend: postData)
        states.postScheduledNotification = ScheduledNotification.from(json: postData)
        states.hasNotification = true
        completionHandler()
    }
}
