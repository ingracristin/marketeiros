//
//  SingleDayView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct SingleDayView: View {
    @EnvironmentObject var monthDataModel: AppDatePickerViewModel
    @Binding var dayInFocus: Date
    var cellSize: CGFloat
    var dayOfMonth: MDPDayOfMonth
    
    // outline "today"
    private var strokeColor: Color {
        monthDataModel.isSelected(dayOfMonth) ? Color(UIColor.appDarkBlue) : Color.clear
    }
    
    // filled if selected
    private var fillColor: Color {
        dayOfMonth.isToday ? Color(UIColor.appDarkBlue) : Color.clear
    }
    
    // reverse color for selections or gray if not selectable
    private var textColor: Color {
        if dayOfMonth.isSelected {
            return monthDataModel.isSelected(dayOfMonth) ? Color.white : Color.black
        }
        return Color.gray
    }
    
    private func handleSelection() {
        monthDataModel.selectDay(dayOfMonth)
    }
    
    var body: some View {
        Button( action: {
            handleSelection()
        } ) {
            if dayOfMonth.isToday {
                Text("\(dayOfMonth.day)")
                    .font(Font.sfProDisplayRegular(sized: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(minHeight: cellSize, maxHeight: cellSize)
                    .background(
                        Circle()
                            .stroke(strokeColor, lineWidth: 1)
                            .background(Circle().foregroundColor(Color(UIColor.appDarkBlue)))
                            .frame(width: cellSize - 5, height: cellSize - 5))
            
            } else if Calendar.current.isDate(dayOfMonth.date!, inSameDayAs:dayInFocus)  {
                Text("\(dayOfMonth.day)")
                    .font(Font.sfProDisplayRegular(sized: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .frame(minHeight: cellSize, maxHeight: cellSize)
                    .background(
                        Circle()
                            .stroke(Color(UIColor.appLightGrey), lineWidth: 1)
                            .background(Circle().foregroundColor(Color(UIColor.appLightGrey)))
                            .frame(width: cellSize - 5, height: cellSize - 5))
            } else {
                if dayOfMonth.isSelected {
                    Text("\(dayOfMonth.day)")
                        .font(Font.sfProDisplayRegular(sized: 16))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.appYellow))
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                        .background(
                            Circle()
                                .stroke(Color.clear, lineWidth: 1)
                                .background(Circle().foregroundColor(Color.clear))
                                .frame(width: cellSize, height: cellSize))
                } else {
                    Text("\(dayOfMonth.day)")
                        .font(Font.sfProDisplayRegular(sized: 16))
                        .fontWeight(.light)
                        .foregroundColor(Color.gray)
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                        .background(
                            Circle()
                                .stroke(Color.clear, lineWidth: 1)
                                .background(Circle().foregroundColor(Color.clear))
                                .frame(width: cellSize, height: cellSize))
                }
            }
        }.foregroundColor(.black)
    }
}

struct MDPDayView_Previews: PreviewProvider {
    static var previews: some View {
        SingleDayView(dayInFocus: .constant(.init()), cellSize: 30, dayOfMonth: .init())
    }
}
