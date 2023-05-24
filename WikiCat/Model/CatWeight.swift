//
//  CatWeight.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import RealmSwift

// Object already extends Codable and Identifiable
class CatWeight: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var imperial: String
    @Persisted var metric: String
    
    // -- MARK: Initializer
    override init() { super.init() }
    init(
        imperial: String,
        metric: String
    ) {
        super.init()
        self.id = UUID()
        self.imperial = imperial
        self.metric = metric
    }
    
    required init(from decoder:Decoder) throws {
        super.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.imperial = try values.decode(String.self, forKey: .imperial)
        self.metric = try values.decode(String.self, forKey: .metric)
    }
    private enum CodingKeys: String, CodingKey {
        case imperial, metric
    }
}
