//
//  CatImage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import RealmSwift

// Object already extends Codable and Identifiable
class CatImage: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var url: String
    @Persisted var width: Int
    @Persisted var height: Int
    
    // -- MARK: Initializer
    override init() { super.init() }
    init(
        id: String,
        url: String,
        width: Int,
        height: Int
    ) {
        super.init()
        self.id = id
        self.url = url
        self.width = width
        self.height = height
    }
    
    required init(from decoder:Decoder) throws {
        super.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.url = try values.decode(String.self, forKey: .url)
        self.width = try values.decode(Int.self, forKey: .width)
        self.height = try values.decode(Int.self, forKey: .height)
    }
    private enum CodingKeys: String, CodingKey {
        case id, url, width, height
    }
}
