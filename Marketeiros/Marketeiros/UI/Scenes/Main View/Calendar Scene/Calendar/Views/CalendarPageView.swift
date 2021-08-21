//
//  CalendarPageView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 15/06/21.
//

import SwiftUI

struct CalendarPageView: View {
    @State private var date = Date()
    @State var offset : CGFloat = 0
    @State var isShowing = false
    @State var allNotifications = [ScheduledNotification]()
    @State var weekNotifications = [Int:[ScheduledNotification]]()
    @State var scheduledDates = [Date]()
    let aux : CGFloat = UIScreen.main.bounds.height * 0.32
    
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
    
    func getNotificationOnWeek(of date: Date) -> [ScheduledNotification] {
        return allNotifications.filter { notification in
            Calendar.current.isDate(notification.date, inCurrentWeekOf: date)!
        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
            VStack(spacing:0) {
                AppDatePicker(anyDays: $scheduledDates, selectedDay: $date)
            }
            
            GeometryReader { reader in
                VStack {
                    BottomSheet(offset: $offset, date: $date, notifications: $weekNotifications, value: (-reader.frame(in: .global).height + aux))
                        .onChange(of: date, perform: { value in
                            print(value)
                            weekNotifications = getWeekNotifications(of: value)
                        })
                        .offset(y: reader.frame(in: .global).height - aux)
                        .offset(y: offset)
                        .gesture(DragGesture().onChanged({ (value) in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + aux) {
                                        offset = value.translation.height
                                    }
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height > 0 && offset < 0 {
                                        offset = (-reader.frame(in: .global).height + aux) + value.translation.height
                                    }
                                }
                            }
                        })
                        .onEnded({ (value) in
                            withAnimation {
                                if value.startLocation.y > reader.frame(in: .global).midX {
                                    if -value.translation.height > (reader.frame(in: .global).midX - 100) {
                                        offset = (-reader.frame(in: .global).height + aux)
                                        return
                                    }
                                    offset = 0
                                }
                                if value.startLocation.y < reader.frame(in: .global).midX {
                                    if value.translation.height < (reader.frame(in: .global).midX - 120) {
                                        offset = (-reader.frame(in: .global).height + aux)
                                        return
                                    }
                                    offset = 0
                                }
                            }
                        }))
                        .ignoresSafeArea(.container, edges: .bottom)
                }
            }
        }
        .sheet(isPresented: $isShowing, content: {
            AddNewEventView()
        })
        .onAppear {
            UserNotificationService.shared.getScheduledNotifications { scheduledNotifications in
                DispatchQueue.main.async {
                    self.allNotifications = scheduledNotifications
                    self.scheduledDates = scheduledNotifications.map({$0.date})
                    self.weekNotifications = getWeekNotifications(of: date)
                }
            }
        }
    }
}

struct CalendarPageView_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            CalendarPageView()
        }
    }
}
