//
//  CalendarPageViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 02/07/21.
//

import Foundation
import SwiftUI

class CalendarPageViewModel: ObservableObject {
    @Published var notifications = [ScheduledNotification]()
    
    func getScheduledNotifications() {
        UserNotificationService.shared.getScheduledNotifications { scheduledNotifications in
            DispatchQueue.main.async {
                self.notifications = scheduledNotifications
            }
        }
    }
    
    func getNotificationOnWeek(of date: Date) -> [ScheduledNotification] {
        return notifications.filter { notification in
            Calendar.current.isDate(notification.date, inCurrentWeekOf: date)!
        }
    }
}
