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
        // TODO: Search another way to wait for URLSession to end
        
        return [
            AppShortcut(
                intent: RandomCatImageIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Show me a picture of a cat"
                ]
            ),
            AppShortcut(
                intent: RandomCatBreedIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Show me a cat",
                    "What is your favorite cat breed"
                ]
            ),
            AppShortcut(
                intent: SpecificCatBreedIntent(),
                phrases: [
                    // Phrases you can say to Siri for her to react
                    "Search for a cat breed"
                ]
            )
        ]
    }
}

struct RandomCatImageIntent: AppIntent {
    static var title: LocalizedStringResource = "Random cat pic"
    static var description = IntentDescription("Show the image of a random cat")
    
    let screenBounds = UIScreen().bounds
    
    func perform() async throws -> some IntentResult {
        let modelData = ModelData()
        var randomImage: UIImage? = nil
        // Get a random CatImage and download it
        await modelData.getARandomImage() {
            data, response, error in
            guard let data = data, error == nil else { return }
            print("random image callback")
            randomImage = UIImage(data: data)
        }
        // Need to wait for the image to finish to download (didn't find any other working solution) TODO: rework
        print("wait 3 sec")
        try await Task.sleep(nanoseconds: UInt64(1.5 * Double(NSEC_PER_SEC)))

        // Send error to user if the image is nil
        print("check random image")
        guard let randomImage = randomImage else {
            throw MyIntentError.message("We couldn't retrieve an image 😿")
        }
        
        // Show the image to the user
        print("return image")
        return .result(
            content: {
                Image(uiImage: randomImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
            }
        )
    }
}

struct RandomCatBreedIntent: AppIntent {
    static var title: LocalizedStringResource = "Random cat breed"
    static var description = IntentDescription("Show the details of a cat breed")
    
    let screenBounds = UIScreen().bounds
    
    func perform() async throws -> some IntentResult {
        let modelData = ModelData()
        var referenceImage: UIImage? = nil
        
        // Get a random CatBreed
        await modelData.fetchBreeds()
        // Wait a second to be sure the breed is retrieved
        try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        guard let catBreed = modelData.breedsList.randomElement() else {
            throw MyIntentError.message("We couldn't retrieve a random breed 😿")
        }
        
        // Get a random CatImage and download it
        if catBreed.image != nil, let url = URL(string: catBreed.image!.url) {
            modelData.downloadImage(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                referenceImage = UIImage(data: data)
            }
            // Need to wait for the image to finish to download (didn't find any other working solution)
            try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        } else if catBreed.reference_image_id != nil {
            // If CatImage is nil in CatBreed check if there is a reference_id
            let url = URL(string: "https://cdn2.thecatapi.com/images/\(catBreed.reference_image_id!).jpg")
            if let url = url {
                modelData.downloadImage(from: url) { data, response, error in
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
}

struct SpecificCatBreedIntent: AppIntent {
    static var title: LocalizedStringResource = "Specific cat breed"
    static var description = IntentDescription("Show the details of a specific cat breed")
    
    let screenBounds = UIScreen().bounds
    
    @Parameter(title: "Breed name")
    var breedName: String
    
    func perform() async throws -> some IntentResult {
        let modelData = ModelData()
        var referenceImage: UIImage? = nil
        
        // Get a random CatBreed
        await modelData.fetchSpecificBreed(breedName: self.breedName)
        // Wait a second to be sure the breed is retrieved
        try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        guard let catBreed = modelData.specificBreed else {
            throw MyIntentError.message("We couldn't retrieve the breed: \(self.breedName) 😿")
        }
        
        // Get a random CatImage and download it
        if catBreed.image != nil, let url = URL(string: catBreed.image!.url) {
            modelData.downloadImage(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                referenceImage = UIImage(data: data)
            }
            // Need to wait for the image to finish to download (didn't find any other working solution) TODO: rework
            try await Task.sleep(nanoseconds: UInt64(1.2 * Double(NSEC_PER_SEC)))
        } else if catBreed.reference_image_id != nil {
            // If CatImage is nil in CatBreed check if there is a reference_id
            let url = URL(string: "https://cdn2.thecatapi.com/images/\(catBreed.reference_image_id!).jpg")
            if let url = url {
                modelData.downloadImage(from: url) { data, response, error in
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
}

enum MyIntentError: Swift.Error, CustomLocalizedStringResourceConvertible {
    case general
    case message(_ message: String)

    var localizedStringResource: LocalizedStringResource {
        switch self {
        case let .message(message): return "\(message)"
        case .general: return "My general error"
        }
    }
}

struct CatBreedDetailsSnippetView: View {
    let catBreed: CatBreed
    let referenceImage: UIImage?
    
    var body: some View {
        VStack {
            if let referenceImage = referenceImage {
                Image(uiImage: referenceImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .cornerRadius(10)
                    .padding(.horizontal, 10)
            }
            VStack(alignment: .leading) {
                // MARK: Important infos
                HStack {
                    Text(self.catBreed.name)
                        .font(.title)
                    Spacer()
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("Lifespan -")
                        .bold()
                    Text("\(self.catBreed.life_span ?? "? - ?") years")
                    Spacer()
                    Text("Weigth -")
                        .bold()
                    Text("\(self.catBreed.weight?.metric ?? "? - ?") Kg")
                }
                .font(.subheadline)
                
                // MARK: More infos / description
                Divider()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                Text("More infos")
                    .font(.title2)
                    .padding(.bottom, 10)
                Text(self.catBreed.description)
                    .frame(maxHeight: .infinity)
                
                // MARK: Breed characteristics
                // TODO: replace breed characteristics by "Open app to see more"
                Divider()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                Text("Breed characteristics")
                    .font(.title2)
                Group {
                    StarRatingDetailField(ratingName: "Affection level", rating: self.catBreed.affection_level)
                    StarRatingDetailField(ratingName: "Lap cat", rating: self.catBreed.lap)
                    StarRatingDetailField(ratingName: "Child friendly", rating: self.catBreed.child_friendly)
                    StarRatingDetailField(ratingName: "Dog friendly", rating: self.catBreed.dog_friendly)
                    StarRatingDetailField(ratingName: "Energy level", rating: self.catBreed.energy_level)
                    StarRatingDetailField(ratingName: "Health issues", rating: self.catBreed.health_issues)
                    StarRatingDetailField(ratingName: "Social needs", rating: self.catBreed.social_needs)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
                // MARK: ---------------------------------------------------------
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer()
        }
        
    }
}
