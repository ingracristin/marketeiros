//
//  UserNotificationService.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 14/06/21.
//

import Foundation
import UserNotifications

struct ScheduledNotification {
    var uid: String
    var title: String
    var description: String
    var boardUid: String
    var boardTitle: String
    var date: Date
    var imagePath: String
}

class UserNotificationService: NSObject,UNUserNotificationCenterDelegate {
    var notificationCenter : UNUserNotificationCenter
    static let shared = UserNotificationService()
    
    struct Constants {
        static let appName = "Planni"
        static let notificationSubtitle = "Está na hora de postar!"
        static let notificationBody = "Você tem um post agendado, clique ser direcionado ao Instagram"
        static let categoryId = "myCategory"
    }
    
    private init(notificationCenter:  UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
        let category = UNNotificationCategory(
            identifier: "myCategory",
            actions: [
                .init(identifier: "Postar", title: "Postar", options: .foreground),
                .init(identifier: "Cancelar", title: "Cancel", options: .destructive)
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
                .init(identifier: "Registrar", title: "Registrar", options: .foreground),
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
                .init(identifier: "Postar", title: "Postar", options: .foreground),
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
    
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { erro in
            print(erro?.localizedDescription)
        }
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
        
        SocialNetworkService.shared.open(socialNetwork: .instagram, andSend: postData)
        completionHandler()
    }
}
