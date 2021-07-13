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
    @Published var states = States()
    
    class States {
        var date: Date = .init()
        var isShowing = false
    }
    
    var bindings: (
        date: Binding<Date>,
        isShowing: Binding<Bool>
    ) {(
        date: Binding(
            get: {self.states.date},
            set: {self.states.date = $0}),
        isShowing: Binding(
            get: {self.states.isShowing},
            set: {self.states.isShowing = $0})
    )}
    
    func toggleIsShowing() {
        states.isShowing.toggle()
    }
    
    func getWeekNotifications(of date: Date) -> [Int:[ScheduledNotification]] {
        var ntf: [Int:[ScheduledNotification]] = [:]
        let weekNotifications = getNotificationOnWeek(of: date)
        
        for weekNotification in weekNotifications {
            let index = Calendar.current.getWeekDayIndexOf(date: weekNotification.date)
            
            if ntf[index] != nil {
                ntf[index]!.append(weekNotification)
            } else {
                ntf[index] = [weekNotification]
            }
        }
    
        return ntf
    }
    
    func getScheduledNotifications() {
        UserNotificationService.shared.getScheduledNotifications { scheduledNotifications in
            DispatchQueue.main.async {
                self.notifications = scheduledNotifications
            }
        }
    }
    
    private func getNotificationOnWeek(of date: Date) -> [ScheduledNotification] {
        return notifications.filter { notification in
            Calendar.current.isDate(notification.date, inCurrentWeekOf: date)!
        }
    }
}
