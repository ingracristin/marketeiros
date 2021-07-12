//
//  BottonSheetListCell.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 16/06/21.
//

import SwiftUI

struct BottonSheetListCell: View {
    var notification: ScheduledNotification
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color(UIColor.appBeige)
                .cornerRadius(21)
            HStack {
                VStack {
                    Spacer()
                    Text(getHourOf(date: notification.date))
                        .foregroundColor(Color(UIColor.appDarkBlue))
                        .font(Font.sfProDisplaySemiBold(sized: 18))
                    Spacer()
                }
                VStack {
                    HStack {
                        Text(notification.title)
                            .foregroundColor(Color(UIColor.appDarkBlue))
                            .cellTitle()
                            .fixedSize(horizontal: true, vertical: false)
                        Spacer()
                    }
                    HStack {
                        Text(notification.description)
                            .foregroundColor(Color(UIColor.appDarkBlue))
                            .cellSubTitle()
                        Spacer()
                    }
                }
                .padding()
            }
            .padding(.horizontal, 30)
        }
    }
    
    private func getHourOf(date: Date) -> String {
        return Calendar.current.getHourAndMinuteFrom(date: date)
    }
}

struct ColaboratorsView: View {
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: -8) {
            Circle()
                .frame(width: 19, height: 19)
                .foregroundColor(.gray)
            Circle()
                .frame(width: 19, height: 19)
            Circle()
                .frame(width: 19, height: 19)
        }
    }
}

//struct BottonSheetListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        BottonSheetListCell(notification: .init(uid: "", title: "", date: .init()))
//    }
//}
