//
//  CatWeight.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import SwiftData

// Object already extends Codable and Identifiable
@Model
class CatWeight:  Identifiable, Decodable, Equatable {
    @Attribute(.unique) var id: UUID
    var imperial: String
    var metric: String
    
    // -- MARK: Initializer
    init(
        imperial: String,
        metric: String
    ) {
        self.id = UUID()
        self.imperial = imperial
        self.metric = metric
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.imperial = try values.decode(String.self, forKey: .imperial)
        self.metric = try values.decode(String.self, forKey: .metric)
    }
    
    private enum CodingKeys: String, CodingKey {
        case imperial, metric
    }
    
    static func ==(lhs: CatWeight, rhs: CatWeight) -> Bool {
        return lhs.id == rhs.id
            && lhs.imperial == rhs.imperial
            && lhs.metric == rhs.metric
    }
}
