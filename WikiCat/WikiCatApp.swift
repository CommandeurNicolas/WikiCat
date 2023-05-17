//
//  WikiCatApp.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

@main
struct WikiCatApp: App {
    @StateObject private var modelData = ModelData.shared
    
    @State var appLoaded: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if appLoaded {
                HomePage()
                    .environmentObject(modelData)
            } else {
                SplashScreen(loaded: $appLoaded)
                    .environmentObject(modelData)
            }
        }
    }
}
