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
    
    init() {
        setViewsAppearence()
    }
    
    var body: some Scene {
        WindowGroup {
            AuthenticationWrapperView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = UserNotificationService.shared
        FirebaseApp.configure()
        return true
    }
}

extension MarketeirosApp {
    private func setViewsAppearence() {
        UITableView.appearance().backgroundColor = .clear
        // nav bar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.navBarTitleColor]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.navBarTitleColor]
        navBarAppearance.backgroundColor = UIColor(.init("navbarColor"))
        navBarAppearance.shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().barTintColor = UIColor(.init("navbarColor"))
        // toolbar
        UIToolbar.appearance().setShadowImage(UIImage(), forToolbarPosition: .any)
        // tabBar
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().clipsToBounds = true
        UITabBar.appearance().isTranslucent = false
        
        // textView
        UITextView.appearance().backgroundColor = .clear
    }
}
