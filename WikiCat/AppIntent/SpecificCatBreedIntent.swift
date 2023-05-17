//
//  SpecificCatBreedIntent.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 11/05/2023.
//

import Foundation
import SwiftUI
import AppIntents

struct SpecificCatBreedIntent: AppIntent {
    static var title: LocalizedStringResource = "Specific cat breed"
    static var description = IntentDescription("Show the details of a specific cat breed")
    
    let screenBounds = UIScreen().bounds
    
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Breed name", requestValueDialog: "What's the name of the breed ?")
    var breedName: String
    
    @MainActor
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let requestManager = HttpRequestManager.shared
        var referenceImage: UIImage? = nil
        
        // Get a random CatBreed
        await requestManager.fetchSpecificBreed(breedName: self.breedName)
        // Wait a second to be sure the breed is retrieved
        try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        guard let catBreed = ModelData.shared.specificBreed else {
            throw MyIntentError.message("We couldn't retrieve the breed: \(self.breedName) 😿")
        }
        
        // Get a random CatImage and download it
        if catBreed.image != nil, let url = URL(string: catBreed.image!.url) {
            requestManager.downloadImage(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                referenceImage = UIImage(data: data)
            }
            // Need to wait for the image to finish to download (didn't find any other working solution) TODO: rework
            try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        } else if catBreed.reference_image_id != nil {
            // If CatImage is nil in CatBreed check if there is a reference_id
            let url = URL(string: "https://cdn2.thecatapi.com/images/\(catBreed.reference_image_id!).jpg")
            if let url = url {
                requestManager.downloadImage(from: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    referenceImage = UIImage(data: data)
                }
                // Need to wait for the image to finish to download (didn't find any other working solution) TODO: rework
                try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
            }
        }
        
        // Show the image to the user
        return .result(
            content: {
                CatBreedDetailsSnippetView(catBreed: catBreed, referenceImage: referenceImage)
            }
        )
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Show the details of \(\.$breedName)")
    }
}
