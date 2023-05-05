//
//  ModelData.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 20/01/2023.
//

import Foundation
import Combine
import UIKit

final class ModelData: ObservableObject {
    private final let base_url = "https://api.thecatapi.com/v1/"
    
    @Published var breedsList: [CatBreed] = []
    var specificBreed: CatBreed? = nil
    var imageView: UIImage? = nil
    
    // Fetch a single specific breed
    func fetchSpecificBreed(breedName: String) async {
        var fullName = breedName
        let components = fullName.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }

        var url: URL?
        
        if words.count == 1 {
            // Change fullName directly to the breed id
            fullName.removeLast(breedName.count - 4)
            url = URL(string: base_url + "breeds/" + fullName)
        } else if words.count == 2 {
            let firstWord = words.first!
            var secondWord = words.last!
            secondWord.removeLast(secondWord.count - 3)
            let breedId = "\(firstWord.first!)\(secondWord)"
            url = URL(string: base_url + "breeds/" + breedId)
        } else {
            print("invalid id")
            return
        }
        
        guard let url = url else {
            print("Invalid URL")
            return
        }
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Retrieving API KEY failed")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            let result = try JSONDecoder().decode(CatBreed.self, from: data)
            DispatchQueue.main.async {
                self.specificBreed = result
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    // Fetch multiple breeds
    func fetchBreeds(number: Int = 100) async {
        guard let url = URL(string: base_url + "breeds?limit=\(number)") else {
            print("Invalid URL")
            return
        }
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Retrieving API KEY failed")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            let result = try JSONDecoder().decode([CatBreed].self, from: data)
            DispatchQueue.main.async {
                self.breedsList = result
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func getARandomImage(completion: @escaping (Data?, URLResponse?, Error?) -> ()) async {
        // Setup URL
        guard let url = URL(string: base_url + "images/search") else {
            print("Invalid URL")
            return
        }
        // Setup API Key
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            print("Retrieving API KEY failed")
            return
        }
        
        // Create HTTP request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        do {
            // Execute the request
            let (data, response) = try await URLSession.shared.data(for: request)
            print("execute request \(response)")
            // Check status code 200
            print("check 200")
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { return }
            // Decode JSON to [CatImage]
            print("JSON converter")
            let result = try JSONDecoder().decode([CatImage].self, from: data)
            // Save the image
            // 'result.first' because we only get one CatImage from this request but still in an Array
            print("download")
            self.downloadImage(from: URL(string: result.first!.url)!) {
                data, response, error in
                print("download completion")
                completion(data, response, error)
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(
            with: url,
            completionHandler: completion
        ).resume()
    }
}
