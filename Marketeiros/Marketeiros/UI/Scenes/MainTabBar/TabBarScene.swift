//
//  TabBarScene.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 03/07/21.
//

import SwiftUI

struct TabBarScene: View {
    var body: some View {
        TabView {
            BoardView()
                .tabItem {
                    Label("Home", systemImage: "square.grid.2x2.fill")
                }
                .accentColor(Color("tabBarItem"))
                .navigationBarHidden(true)
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
    }
}

struct TabBarScene_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScene()
    }
}
