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
    var notifications: [ScheduledNotification]
    var value : CGFloat
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,8)
            
            Text("Eventos da semana")
                .foregroundColor(.white)
                .bold()
                .padding(.bottom,15)
            
            ScrollView(.vertical, showsIndicators: false, content: {
                Text(Calendar.current.getDescriptionOf(date: date))
                    .foregroundColor(.white)
                LazyVStack(alignment: .leading, spacing: 15, content: {
                    ForEach(notifications, id: \.uid) { notification in
                        BottonSheetListCell(notification: notification)
                            .padding(.horizontal)
                            .padding(.bottom)
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
        BottomSheet(offset: .constant(0), date: .constant(.init()), notifications: [], value: 400)
    }
}
