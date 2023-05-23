//
//  WikiCatApp.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

@main
struct WikiCatApp: App {
    @State var appLoaded: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if appLoaded {
                HomePage()
            } else {
                SplashScreen(loaded: $appLoaded)
            }
        }
    }
}
