//
//  MonthView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct MonthView: View {
    @EnvironmentObject var monthDataModel: AppDatePickerViewModel
    @State private var showMonthYearPicker = false
    @State private var testDate = Date()
    
    private func showPrevMonth() {
        withAnimation {
            monthDataModel.decrMonth()
            showMonthYearPicker = false
        }
    }
    
    private func showNextMonth() {
        withAnimation {
            monthDataModel.incrMonth()
            showMonthYearPicker = false
        }
    }
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width / 8
            VStack {
                HStack {
                    MonthYearPickerButton(isPresented: self.$showMonthYearPicker)
                    Spacer()
                    Button( action: {showPrevMonth()} ) {
                        Image(systemName: "chevron.left")
                            .font(.title3)
                            .foregroundColor(Color(UIColor.navBarTitleColor))
                    }.padding(.horizontal,10)
                    Button( action: {showNextMonth()} ) {
                        Image(systemName: "chevron.right")
                            .font(.title3)
                            .foregroundColor(Color(UIColor.navBarTitleColor))
                    }.padding(.trailing)
                }
                .padding(.leading, 18)
                
                if showMonthYearPicker {
                    MonthYearPicker(date: monthDataModel.controlDate) { (month, year) in
                        self.monthDataModel.show(month: month, year: year)
                    }
                }
                else {
                    MonthDaysView(cellSize: width)
                }
            }
            .frame(width: reader.size.width, height: reader.size.width)
        }
    }
}

struct MonthView_Previews: PreviewProvider {
    static var previews: some View {
        MonthView()
            .environmentObject(AppDatePickerViewModel())
    }
}
