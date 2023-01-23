//
//  ModelData.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 20/01/2023.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    @Published var breedsList: [CatBreed] = []
    
    func fetchBreeds() {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds?limit=10") else {
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
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode([CatBreed].self, from: data)
                    DispatchQueue.main.async {
                        self.breedsList = result
                    }
                    return
                } catch { print("breeds error \(error)") }
            }
        }.resume()
    }
}
