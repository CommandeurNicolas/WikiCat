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
    let country_code: String
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
        case id, weight, name, cfa_url, vetstreet_url, vcahospitals_url, wikipedia_url, temperament, origin, country_code, description, life_span, alt_names, experimental, hairless, natural, rare, rex, suppressed_tail, short_legs, hypoallergenic, indoor, lap, adaptability, affection_level, child_friendly, dog_friendly, energy_level, grooming, health_issues, intelligence, shedding_level, social_needs, stranger_friendly, vocalisation, reference_image_id, image
    }
    
    static let test: CatBreed = CatBreed(
        id: "aege",
        weight: CatWeight(imperial: "7 - 10", metric: "3 - 5"),
        name: "Aegean",
        cfa_url: nil,
        vetstreet_url: "http://www.vetstreet.com/cats/aegean-cat",
        vcahospitals_url: nil,
        wikipedia_url: nil,
        temperament: "Affectionate, Social, Intelligent, Playful, Active",
        origin: "Greece",
        country_code: "GR",
        description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
        life_span: "9 - 12",
        alt_names: "",
        experimental: 0,
        hairless: 0,
        natural: 0,
        rare: 0,
        rex: 0,
        suppressed_tail: 0,
        short_legs: 0,
        hypoallergenic: 0,
        indoor: 0,
        lap: 1,
        adaptability: 5,
        affection_level: 4,
        child_friendly: 4,
        dog_friendly: 4,
        energy_level: 3,
        grooming: 3,
        health_issues: 1,
        intelligence: 3,
        shedding_level: 3,
        social_needs: 4,
        stranger_friendly: 4,
        vocalisation: 3,
        reference_image_id: "ozEvzdVM-",
        image: CatImage(id: "ozEvzdVM-", url: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg", width: 1200, height: 800)
    )
}
