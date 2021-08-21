//
//  TabBarScene.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 03/07/21.
//

import SwiftUI

struct TabBarScene: View {
    @State var tabSelection = 0
    @State var boardViewImage = "square.grid.2x2.fill"
    @State var calendarViewImage = "calendar"
    @State var profileViewImage = "person"
    var body: some View {
        NavigationView {
            VStack {
//                NavigationLink(
//                    destination:
//                        SharePostView(scheduledNotification: UserNotificationService.shared.bindings.scheduledNotification)
//                        .navigationBarHidden(true),
//                    isActive: UserNotificationService.shared.bindings.hasNotification,
//                    label: {
//                        EmptyView()
//                    })
                TabView(selection: $tabSelection){
                    BoardView()
                    .tabItem {
                        Label("Home", systemImage: boardViewImage)
                    }
                    .tag(0)
                    .accentColor(Color("tabBarItem"))
                    
                    CalendarPageView()
                        .tabItem {
                            Label(NSLocalizedString("calendar", comment: ""), systemImage: calendarViewImage)
                        }
                        .tag(1)
                        .accentColor(Color("tabBarItem"))
                        .navigationBarHidden(true)
                    
                    ProfileView()
                        .tabItem {
                            Label(NSLocalizedString("profile", comment: ""), systemImage: profileViewImage)
                        }
                        .tag(2)
                        .accentColor(Color("tabBarItem"))
                        .navigationBarHidden(true)
                } .accentColor(Color(UIColor.appLightBlue))
                .onChange(of: tabSelection, perform: { value in
                    switch tabSelection{
                    case 0:
                        boardViewImage = "square.grid.2x2.fill"
                        calendarViewImage = "calendar"
                        profileViewImage = "person"
                    case 1:
                        boardViewImage = "square.grid.2x2"
                        calendarViewImage = "calendar"
                        profileViewImage = "person"
                    case 2:
                        boardViewImage = "square.grid.2x2"
                        calendarViewImage = "calendar"
                        profileViewImage = "person.fill"
                    default:
                        boardViewImage = "square.grid.2x2.fill"
                        calendarViewImage = "calendar"
                        profileViewImage = "person"
                        
                    }
                })
            }

        }.accentColor(Color(UIColor.navBarItemsColor))
    }
}

struct TabBarScene_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScene()
    }
}
