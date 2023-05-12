//
//  RandomImageIntent.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 11/05/2023.
//

import Foundation
import SwiftUI
import UIKit
import AppIntents

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        ModelData.shared.randomCatImage = nil
        print("Save finished!")
    }
}
struct RandomCatImageIntent: AppIntent  {
    static var title: LocalizedStringResource = "Random cat pic"
    static var description = IntentDescription("Show the image of a random cat")
    
    let screenBounds = UIScreen().bounds
    
    static var openAppWhenRun: Bool = false
    
    @MainActor
    func perform() async throws -> some IntentResult & ShowsSnippetView {
        let modelData = ModelData.shared
        var randomImage: UIImage? = nil
        // Get a random CatImage and download it
        await modelData.getARandomImage() {
            data, response, error in
            guard let data = data, error == nil else { return }
            randomImage = UIImage(data: data)
        }
        // Need to wait for the image to finish to download (didn't find any other working solution) TODO: rework
        try await Task.sleep(nanoseconds: UInt64(1.5 * Double(NSEC_PER_SEC)))

        // Send error to user if the image is nil
        guard let randomImage = randomImage else {
            throw MyIntentError.message("We couldn't retrieve an image 😿")
        }
        modelData.randomCatImage = randomImage
        
        // Show the image to the user
        return .result(
            value: IntentFile(data: randomImage.pngData()!, filename: "randomCatImage"),
            dialog: "Here is an image of a cat",
            content: {
                VStack {
                    Image(uiImage: randomImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.horizontal, 10)
                }
            }
        )
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Show a random image of a cat")
    }
}
struct SaveImageIntent: AppIntent {
    static var title: LocalizedStringResource = "Save the image"
    static var description = IntentDescription("Save the image to photo gallery")
    
    static var openAppWhenRun: Bool = false
    
    @Parameter(title: "Do you want to save the image ?")
    var doSaveImage: Bool
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let modelData = ModelData.shared
        guard let randomImage = modelData.randomCatImage else {
            throw MyIntentError.message("There is no image to save 😿")
        }
        
        let saveImageFunc = {
            let imageSaver = ImageSaver()
            imageSaver.writeToPhotoAlbum(image: randomImage)
        }
        
        if doSaveImage {
            saveImageFunc()
        } else {
            let confirmed: Bool = try await $doSaveImage.requestConfirmation(for: doSaveImage)
            confirmed ? saveImageFunc() : nil
        }
        
        return .result()
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Save the random image in photo gallery")
    }
}
