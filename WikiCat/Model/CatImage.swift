//
//  CatImage.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import SwiftData

// Object already extends Codable and Identifiable
@Model
class CatImage: Decodable, Equatable {
    @Attribute(.unique) var id: String
    var url: String
    var width: Int
    var height: Int
    
    // -- MARK: Initializer
    init(
        id: String,
        url: String,
        width: Int,
        height: Int
    ) {
        self.id = id
        self.url = url
        self.width = width
        self.height = height
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.url = try values.decode(String.self, forKey: .url)
        self.width = try values.decode(Int.self, forKey: .width)
        self.height = try values.decode(Int.self, forKey: .height)
    }

    private enum CodingKeys: String, CodingKey {
        case id, url, width, height
    }
    
    static func ==(lhs: CatImage, rhs: CatImage) -> Bool {
        return lhs.id == rhs.id
            && lhs.url == rhs.url
            && lhs.width == rhs.width
            && lhs.height == rhs.height
    }
}
