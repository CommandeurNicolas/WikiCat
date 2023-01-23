//
//  WikiCatApp.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import SwiftUI

@main
struct WikiCatApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            HomePage()
                .environmentObject(modelData)
        }
    }
}
