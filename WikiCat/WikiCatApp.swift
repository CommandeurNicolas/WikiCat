//
//  WikiCatApp.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

@main
struct WikiCatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        // MARK: Changing top bar title style
        let appearance  = UINavigationBarAppearance()

        let largeAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Asap-SemiBold", size: 32)!
        ]
        let inlineAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Asap-Medium", size: 24)!
        ]

        appearance.largeTitleTextAttributes = largeAttrs
        appearance.titleTextAttributes = inlineAttrs
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
        return true
    }
}
