//
//  CatWeight.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation

struct CatWeight: Codable, Identifiable {
    let id = UUID()
    let imperial: String
    let metric: String
    
    private enum CodingKeys: String, CodingKey {
        case imperial, metric
    }
}
