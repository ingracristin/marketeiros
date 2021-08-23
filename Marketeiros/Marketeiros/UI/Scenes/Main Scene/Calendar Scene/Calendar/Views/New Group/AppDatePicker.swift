//
//  AppDatePicker.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct AppDatePicker: View {
    @ObservedObject var monthModel: AppDatePickerViewModel
    
    init(anyDays: Binding<[Date]>,
         selectedDay: Binding<Date>,
         minDate: Date? = nil,
         maxDate: Date? = nil
    ) {
        _monthModel = ObservedObject(wrappedValue: AppDatePickerViewModel(anyDays: anyDays, selectedDay: selectedDay))
    }
    
    var body: some View {
        MonthView()
            .environmentObject(monthModel)
    }
}

//struct AppDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        AppDatePicker()
//    }
//}
