//
//  MonthDaysView.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import SwiftUI

struct MonthDaysView: View {
    @EnvironmentObject var monthDataModel: AppDatePickerViewModel
    var cellSize: CGFloat
    var columns: [GridItem]
    
    init(cellSize: CGFloat) {
        self.columns = [GridItem](repeating: GridItem(.fixed(cellSize), spacing: 2), count: 7)
        self.cellSize = cellSize
    }
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<monthDataModel.dayNames.count, id: \.self) { index in
                Text(monthDataModel.dayNames[index].lowercased().removeCharactersContained(in: "."))
                    .font(Font.sfProDisplaySemiBold(sized: 16))
                    .foregroundColor(Color(UIColor.appYellow))
            }
            .padding(.bottom, 10)
            
            ForEach(0..<monthDataModel.days.count, id: \.self) { index in
                if monthDataModel.days[index].day == 0 {
                    Text("")
                        .frame(minHeight: cellSize, maxHeight: cellSize)
                } else {
                    SingleDayView(dayInFocus: monthDataModel.selectedDay!, cellSize: cellSize, dayOfMonth: monthDataModel.days[index])
                }
            }
        }.padding(.bottom, 10)
    }
}

struct MonthContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonthDaysView(cellSize: 30)
    }
}
