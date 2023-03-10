//
//  CatBreed.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation

struct CatBreed: Codable, Identifiable {
    let id: String
    let weight: CatWeight?
    let name: String
    let cfa_url: String?
    let vetstreet_url: String?
    let vcahospitals_url: String?
    let wikipedia_url: String?
    let temperament: String?
    let origin: String
    //    let country_codes: String
    //    let country_code: String
    let description: String
    let life_span: String?
    let alt_names: String?
    
    private let experimental: Int?
    var isExperimental: Bool {
        return experimental == 1
    }
    private let hairless: Int?
    var isHairless: Bool {
        return hairless == 1
    }
    private let natural: Int?
    var isNatural: Bool {
        return natural == 1
    }
    private let rare: Int?
    var isRare: Bool {
        return rare == 1
    }
    private let rex: Int?
    var isRex: Bool {
        return rex == 1
    }
    private let suppressed_tail: Int?
    var hasSuppressedTail: Bool {
        return suppressed_tail == 1
    }
    private let short_legs: Int?
    var hasShortLegs: Bool {
        return short_legs == 1
    }
    private let hypoallergenic: Int?
    var isHypoallergenic: Bool {
        return hypoallergenic == 1
    }
    
    
    // Star levels
    let indoor: Int?
    let lap: Int?
    let adaptability: Int?
    let affection_level: Int?
    let child_friendly: Int?
    let dog_friendly: Int?
    let energy_level: Int?
    let grooming: Int?
    let health_issues: Int?
    let intelligence: Int?
    let shedding_level: Int?
    let social_needs: Int?
    let stranger_friendly: Int?
    let vocalisation: Int?
    
    // Image
    let reference_image_id: String?
    let image: CatImage?
    
    var isFavorite: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case id, weight, name, cfa_url, vetstreet_url, vcahospitals_url, wikipedia_url, temperament, origin, description, life_span, alt_names, experimental, hairless, natural, rare, rex, suppressed_tail, short_legs, hypoallergenic, indoor, lap, adaptability, affection_level, child_friendly, dog_friendly, energy_level, grooming, health_issues, intelligence, shedding_level, social_needs, stranger_friendly, vocalisation, reference_image_id, image
    }
}
