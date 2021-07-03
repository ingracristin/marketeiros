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
                    Label("Quadros", systemImage: "square.grid.2x2.fill")
                }        .navigationTitle(Text("Home"))
            CalendarPageView()
                .tabItem {
                    Label("Calendário", systemImage: "calendar")
                }.navigationBarHidden(true)
        }
    }
}

struct TabBarScene_Previews: PreviewProvider {
    static var previews: some View {
        TabBarScene()
    }
}
