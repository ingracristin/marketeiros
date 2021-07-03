//
//  CalendarExtensions.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 15/06/21.
//

import Foundation

extension Calendar {
    func isDate(_ firstDate: Date, inCurrentWeekOf secondDate: Date = .init()) -> Bool? {
        let firstDateComponents = self.dateComponents([.weekOfYear], from: firstDate)
        let secondDateComponents = self.dateComponents([.weekOfYear], from: secondDate)

        guard let firstDateWeek = firstDateComponents.weekOfYear, let secondDateWeek = secondDateComponents.weekOfYear else { return nil }
        
        return firstDateWeek == secondDateWeek
    }
    
    func isDate(_ firstDate: Date, inCurrentWeekAndDayOf secondDate: Date = .init()) -> Bool? {
        let firstDateComponents = self.dateComponents([.weekOfYear,.day], from: firstDate)
        let secondDateComponents = self.dateComponents([.weekOfYear,.day], from: secondDate)

        guard
            let firstDateWeek = firstDateComponents.weekOfYear,
            let secondDateWeek = secondDateComponents.weekOfYear,
            let firstDateDay = firstDateComponents.day,
            let secondDateDay = secondDateComponents.day
              else { return nil }
        
        return (firstDateWeek == secondDateWeek) && (firstDateDay == secondDateDay)
    }
    
    func isDate(_ firstDate: Date, inCurrentWeekOf index : Int) -> Bool? {
        let firstDateComponents = self.dateComponents([.weekOfYear], from: firstDate)
        guard let firstDateWeek = firstDateComponents.weekOfYear else { return nil }
        
        return firstDateWeek == index
    }
    
    func isDate(_ date : Date, onTheSameWeekDayOf secondDate : Date) -> Bool {
        let firstComponents = self.dateComponents([.weekday], from: date)
        let secondComponents = self.dateComponents([.weekday], from: secondDate)

        return firstComponents.weekday == secondComponents.weekday
    }
    
    func getYearWeekOf(_ date: Date = .init()) -> Int? {
        let firstDateComponents = self.dateComponents([.weekOfYear], from: date)
        guard let firstDateWeek = firstDateComponents.weekOfYear else { return nil }
        
        return firstDateWeek
    }
    
    func getWeekDayIndexOf(date : Date) -> Int {
        self.dateComponents([.weekday], from: date).weekday! - 1
    }
    
    func getMonthDayOf(date : Date) -> Int {
        self.component(.day, from: date)
    }
    
    func getMonthFrom(date : Date) -> String {
        let monthIndex = self.component(.month, from: date) - 1
        return self.monthSymbols[monthIndex]
    }
    
    func getHourAndMinuteFrom(date : Date) -> String {
        let hour = self.component(.hour, from: date)
        let minute = self.component(.minute, from: date)
        return "\(hour):\(minute)"
    }
    
    func getWeekDayDescriptionFrom(date : Date) -> String {
        let dayIndex = self.component(.weekday, from: date)
        return self.weekdaySymbols[dayIndex]
    }
    
    func getDescriptionOf(date : Date) -> String {
        let components = self.dateComponents([.weekday,.day,.month], from: date)
        let weekDayIndex = components.weekday! - 1
        let monthIndex = components.month! - 1
        return "\(self.weekdaySymbols[weekDayIndex]), \(components.day!) of \(self.monthSymbols[monthIndex])"
    }
    
//    func getDescriptionOf(date : Date, with dateComponents : [Calendar.Component]) -> String {
//        let components = self.dateComponents(Set(dateComponents), from: date)
//        let componentsList = components.description.split(separator: " ")
//        var description = ""
//
//        for component in dateComponents {
//            switch component {
//            case .era:
//                <#code#>
//            case .year:
//                <#code#>
//            case .month:
//                <#code#>
//            case .day:
//                description += componentsList[]
//            case .hour:
//                <#code#>
//            case .minute:
//                <#code#>
//            case .second:
//                <#code#>
//            case .weekday:
//                <#code#>
//            case .weekdayOrdinal:
//                <#code#>
//            case .quarter:
//                <#code#>
//            case .weekOfMonth:
//                <#code#>
//            case .weekOfYear:
//                <#code#>
//            case .yearForWeekOfYear:
//                <#code#>
//            case .nanosecond:
//                <#code#>
//            case .calendar:
//                <#code#>
//            case .timeZone:
//                <#code#>
//            @unknown default:
//                <#code#>
//            }
//        }
//
//        return components.description
//    }
}
