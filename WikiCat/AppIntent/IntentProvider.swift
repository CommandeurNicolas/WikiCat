//
//  IntentProvider.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 04/05/2023.
//

import Foundation
import AppIntents
import SwiftUI

struct IntentProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        return [
            AppShortcut(
                intent: RandomCatImageIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Show me a picture of a cat"
                ],
                systemImageName: "photo"
            ),
            AppShortcut(
                intent: RandomCatBreedIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Show me a cat",
                    "What is your favorite cat breed"
                ],
                systemImageName: "text.below.photo"
            ),
            AppShortcut(
                intent: SpecificCatBreedIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Search for a cat breed"
                ],
                systemImageName: "text.below.photo"
            )
        ]
    }
}
