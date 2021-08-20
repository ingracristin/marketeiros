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
    @Binding var notifications: [Int: [ScheduledNotification]]
    @State var isPostDetailsPresented = false
    @State var selectedPost: ScheduledNotification = ScheduledNotification(uid: "", title: "", description: "", boardUid: "", boardTitle: "", date: .init(), imagePath: "")
    var value : CGFloat
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.white)
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom,8)
            HStack(alignment:.center, spacing:0){
                if offset < 0 {
                    Button(action: {}, label: {
                        Text("OK")
                    })
                    .foregroundColor(.white)
                    .padding(.leading,20)
                    .isHidden(true)
                }
                Spacer()
                Text(NSLocalizedString("eventWeek", comment: ""))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom,5)
                Spacer()
                if offset < 0 {
                    Button(action: {
                        withAnimation {
                            offset = 0
                        }
                    }, label: {
                        Text("OK")
                    })
                    .foregroundColor(.white)
                    .padding(.trailing,20)
                }
            }
            if notifications.isEmpty {
                EmptyScheduledPostsCard()
                    .padding()
                    //.padding(.top,30)
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false, content: {
                    LazyVStack(alignment: .leading, spacing: 15, content: {
                        ForEach(notifications.keys.sorted(), id:\.self) { index in
                            HStack {
                                Spacer()
                                Text(Calendar.current.getDescriptionOf(date: notifications[index]!.first!.date))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            ForEach(notifications[index]!, id:\.uid) { notification in
                                BottonSheetListCell(notification: notification)
                                    .onTapGesture {
                                        selectedPost = notification
                                        isPostDetailsPresented.toggle()
                                    }
                            }
                        }
                    })
                    //.padding(.vertical)
                    .padding(.horizontal,25)
                })
            }
        }
        .background(CornerShapeView(corners: [.topLeft,.topRight], radius: 30).foregroundColor(Color(UIColor.appDarkBlue)))
        .sheet(isPresented: $isPostDetailsPresented) {
            ScheduledPostDetails(scheduledNotification: $selectedPost)
        }
    }
}

struct BottonSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(offset: .constant(0), date: .constant(.init()), notifications: .constant([:]), value: 400)
    }
}
