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
    
    func getMonthFrom(date : Date) -> String {
        let monthIndex = self.component(.month, from: date) - 1
        return self.monthSymbols[monthIndex]
    }
}
