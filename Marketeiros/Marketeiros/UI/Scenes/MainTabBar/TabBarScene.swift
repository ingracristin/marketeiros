//
//  TabBarScene.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 03/07/21.
//

import SwiftUI

struct TabBarScene: View {
    var body: some View {
        NavigationView {
            TabView {
                BoardView()
                .tabItem {
                    Label("Home", systemImage: "square.grid.2x2.fill")
                }
                .accentColor(Color("tabBarItem"))
                
                CalendarPageView()
                    .tabItem {
                        Label("Calendário", systemImage: "calendar")
                    }
                    .accentColor(Color("tabBarItem"))
                    .navigationBarHidden(true)
                
                ProfileView()
                    .tabItem {
                        Label("Perfil", systemImage: "person.fill")
                    }
                    .accentColor(Color("tabBarItem"))
                    .navigationBarHidden(true)
            }
            .accentColor(Color(UIColor.appLightBlue))
        }
    }
}

struct TabBarScene_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScene()
    }
}
