//
//  BottonSheet.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 15/06/21.
//

import SwiftUI

struct BottomSheet : View {
    @Binding var offset : CGFloat
    @Binding var date : Date
    var notifications: [Int: [ScheduledNotification]]
    var value : CGFloat
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.white)
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,8)
            
            Text(NSLocalizedString("eventWeek", comment: ""))
                .foregroundColor(.white)
                .bold()
                .padding(.bottom,5)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack(alignment: .leading, spacing: 15, content: {
                    ForEach(notifications.keys.sorted(), id:\.self) { index in
                        HStack {
                            Spacer()
                            Text(Calendar.current.getDescriptionOf(date: notifications[index]!.first!.date))
                                .foregroundColor(.white)
                            Spacer()
                        }
                        ForEach(Array(notifications[index]!), id:\.uid) { notification in
                            BottonSheetListCell(notification: notification)
                        }
                    }
                })
                .padding(.vertical)
                .padding(.horizontal,25)
            })
        }
        .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color(UIColor.appDarkBlue)))
    }
}

struct BottonSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(offset: .constant(0), date: .constant(.init()), notifications: [:], value: 400)
    }
}
