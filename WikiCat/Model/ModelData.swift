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
    static let shared: ModelData = ModelData()
    
    @Published var breedsList: [CatBreed] = []
    var specificBreed: CatBreed? = nil
    var randomCatImage: UIImage? = nil
}


