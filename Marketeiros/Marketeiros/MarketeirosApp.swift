//
//  MarketeirosApp.swift
//  Marketeiros
//
//  Created by Ingra Cristina on 14/06/21.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct MarketeirosApp: App {
    private let notificationService = UserNotificationService.shared
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: {
                    UNUserNotificationCenter.current().delegate = UserNotificationService.shared
                })
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
