//
//  AppDatePickerViewModel.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI
import Combine

class AppDatePickerViewModel: NSObject, ObservableObject {
    @Published var days = [MDPDayOfMonth]()
    @Published var title = ""
    @Published var dayInFocus = Date()
    let dayNames = Calendar.current.shortWeekdaySymbols
    private var selectedDates: Binding<[Date]>!
    var selectedDay: Binding<Date>?
    private var numDays = 0
    
    public var controlDate: Date = Date() {
        didSet {
            buildDays()
        }
    }

    convenience init(
        anyDays: Binding<[Date]>,
        selectedDay: Binding<Date>) {
        
        self.init()
        self.selectedDay = selectedDay
        self.selectedDates = anyDays

        if let useDate = anyDays.wrappedValue.first {
            controlDate = useDate
        }
        buildDays()
    }
    
    func dayOfMonth(byDay: Int) -> MDPDayOfMonth? {
        guard 1 <= byDay && byDay <= 31 else { return nil }
        for dom in days {
            if dom.day == byDay {
                return dom
            }
        }
        return nil
    }
    
    func selectDay(_ day: MDPDayOfMonth) {
        guard let date = day.date else { return }
        
        selectedDay?.wrappedValue = date
        dayInFocus = date
    }
    
    func checkIf(dayIsOnFocus day: MDPDayOfMonth) -> Bool {
        return Calendar.current.isDate(day.date!, inSameDayAs: selectedDay!.wrappedValue)
    }
    
    func isSelected(_ day: MDPDayOfMonth) -> Bool {
        print(day.isSelected)
        return day.isSelected
    }
    
    func incrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: 1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func decrMonth() {
        let calendar = Calendar.current
        if let newDate = calendar.date(byAdding: .month, value: -1, to: controlDate) {
            controlDate = newDate
        }
    }
    
    func show(month: Int, year: Int) {
        let calendar = Calendar.current
        let components = DateComponents(year: year, month: month, day: 1)
        if let newDate = calendar.date(from: components) {
            controlDate = newDate
        }
    }
}

extension AppDatePickerViewModel {
    private func buildDays() {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: controlDate)
        let month = calendar.component(.month, from: controlDate)
        
        let dateComponents = DateComponents(year: year, month: month)
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        
        let ord = calendar.component(.weekday, from: date)
        var index = 0
        
        let today = Date()
        
        var daysArray = [MDPDayOfMonth]()
        
        // for 0 to ord, set the value in the array[index] to be 0, meaning no day here.
        for _ in 1..<ord {
            daysArray.append(MDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        // for index in range, create a DayOfMonth that will represent one of the days
        // in the month. This object needs to be told if it is eligible for selection
        // which is based on the selectionType and min/max dates if present.
        for i in 0..<numDays {
            let realDate = calendar.date(from: DateComponents(year: year, month: month, day: i+1))
            var dom = MDPDayOfMonth(index: index, day: i+1, date: realDate)
            dom.isToday = calendar.isDate(today, inSameDayAs: realDate!)
            for selectedDays in selectedDates!.wrappedValue {
                if calendar.isDate(selectedDays, inSameDayAs: dom.date!) {
                    dom.isSelected = true
                }
            }
            daysArray.append(dom)
            index += 1
        }
        
        // if index is not a multiple of 7, then append 0 to array until the next 7 multiple.
        let total = daysArray.count
        var remainder = 42 - total
        if remainder < 0 {
            remainder = 42 - total
        }
        
        for _ in 0..<remainder {
            daysArray.append(MDPDayOfMonth(index: index, day: 0))
            index += 1
        }
        
        self.numDays = numDays
        self.title = "\(calendar.monthSymbols[month-1]) \(year)".capitalized
        self.days = daysArray
    }
}
