//
//  AppDatePicker.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct AppDatePicker: View {
    @StateObject var monthModel: AppDatePickerViewModel
    @Binding var days: [Date]
    
    init(anyDays: Binding<[Date]>,
         selectedDay: Binding<Date>,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = StateObject(wrappedValue: AppDatePickerViewModel(anyDays: anyDays, selectedDay: selectedDay))
        _days = anyDays
    }
    
    var body: some View {
        MonthView()
            .environmentObject(monthModel)
            .onChange(of: days) { _ in
                monthModel.buildDays()
            }
    }
}

//struct AppDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        AppDatePicker()
//    }
//}
