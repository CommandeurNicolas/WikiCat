//
//  CatBreed.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import SwiftData

@Model
class CatBreed: Decodable, Equatable {
    @Attribute(.unique) var id: String
    var name: String
    var weight: CatWeight
    var cfaURL: String?
    var vetstreetURL: String?
    var vcahospitalsURL: String?
    var wikipediaURL: String?
    var temperament: String
    var origin: String
    var countryCode: String
    var catDescription: String
    var altNames: String?
    var lifeSpan: String
    // Attributes
    var experimental: Int
    var hairless: Int
    var natural: Int
    var rare: Int
    var rex: Int
    var suppressedTail: Int
    var shortLegs: Int
    var hypoallergenic: Int
    // Star levels
    var indoor: Int?
    var lap: Int?
    var adaptability: Int?
    var affectionLevel: Int?
    var childFriendly: Int?
    var dogFriendly: Int?
    var energyLevel: Int?
    var grooming: Int?
    var healthIssues: Int?
    var intelligence: Int?
    var sheddingLevel: Int?
    var socialNeeds: Int?
    var strangerFriendly: Int?
    var vocalisation: Int?
    var catFriendly: Int?
    var bidability: Int?
    // Image
    var referenceImageID: String?
    var image: CatImage?
    
    // Attributes
    @Transient var isExperimental: Bool {
        return experimental == 1
    }
    @Transient var isHairless: Bool {
        return hairless == 1
    }
    @Transient var isNatural: Bool {
        return natural == 1
    }
    @Transient var isRare: Bool {
        return rare == 1
    }
    @Transient var isRex: Bool {
        return rex == 1
    }
    @Transient var hasSuppressedTail: Bool {
        return suppressedTail == 1
    }
    @Transient var hasShortLegs: Bool {
        return shortLegs == 1
    }
    @Transient var isHypoallergenic: Bool {
        return hypoallergenic == 1
    }
    @Transient var hasAttributes: Bool {
        return isExperimental
        || isHairless
        || isNatural
        || isRare
        || isRex
        || hasSuppressedTail
        || hasShortLegs
        || isHypoallergenic
    }
    
    // Saved as favorite
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case weight, id, name, temperament, origin, indoor, lap, adaptability, grooming, intelligence, vocalisation, experimental, hairless, natural, rare, rex, hypoallergenic, bidability, image
        case cfaURL = "cfa_url"
        case vetstreetURL = "vetstreet_url"
        case vcahospitalsURL = "vcahospitals_url"
        case wikipediaURL = "wikipedia_url"
        case countryCodes = "country_codes"
        case countryCode = "country_code"
        case catDescription = "description"
        case lifeSpan = "life_span"
        case altNames = "alt_names"
        case affectionLevel = "affection_level"
        case childFriendly = "child_friendly"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case healthIssues = "health_issues"
        case sheddingLevel = "shedding_level"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case shortLegs = "short_legs"
        case catFriendly = "cat_friendly"
        case referenceImageID = "reference_image_id"
    }
    
    init(id: String, name: String, weight: CatWeight, cfaURL: String? = nil, vetstreetURL: String? = nil, vcahospitalsURL: String? = nil, wikipediaURL: String? = nil, temperament: String, origin: String, countryCode: String, catDescription: String, altNames: String? = nil, lifeSpan: String, indoor: Int, lap: Int? = nil, adaptability: Int, affectionLevel: Int, childFriendly: Int, dogFriendly: Int, energyLevel: Int, grooming: Int, healthIssues: Int, intelligence: Int, sheddingLevel: Int, socialNeeds: Int, strangerFriendly: Int, vocalisation: Int, experimental: Int, hairless: Int, natural: Int, rare: Int, rex: Int, suppressedTail: Int, shortLegs: Int, hypoallergenic: Int, catFriendly: Int? = nil, bidability: Int? = nil, referenceImageID: String? = nil, image: CatImage? = nil) {
        self.weight = weight
        self.id = id
        self.name = name
        self.cfaURL = cfaURL
        self.vetstreetURL = vetstreetURL
        self.vcahospitalsURL = vcahospitalsURL
        self.temperament = temperament
        self.origin = origin
        self.countryCode = countryCode
        self.catDescription = catDescription
        self.lifeSpan = lifeSpan
        self.indoor = indoor
        self.lap = lap
        self.altNames = altNames
        self.adaptability = adaptability
        self.affectionLevel = affectionLevel
        self.childFriendly = childFriendly
        self.dogFriendly = dogFriendly
        self.energyLevel = energyLevel
        self.grooming = grooming
        self.healthIssues = healthIssues
        self.intelligence = intelligence
        self.sheddingLevel = sheddingLevel
        self.socialNeeds = socialNeeds
        self.strangerFriendly = strangerFriendly
        self.vocalisation = vocalisation
        self.experimental = experimental
        self.hairless = hairless
        self.natural = natural
        self.rare = rare
        self.rex = rex
        self.suppressedTail = suppressedTail
        self.shortLegs = shortLegs
        self.wikipediaURL = wikipediaURL
        self.hypoallergenic = hypoallergenic
        self.referenceImageID = referenceImageID
        self.image = image
        self.catFriendly = catFriendly
        self.bidability = bidability
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.weight = try container.decode(CatWeight.self, forKey: .weight)
        self.cfaURL = try container.decodeIfPresent(String.self, forKey: .cfaURL)
        self.vetstreetURL = try container.decodeIfPresent(String.self, forKey: .vetstreetURL)
        self.vcahospitalsURL = try container.decodeIfPresent(String.self, forKey: .vcahospitalsURL)
        self.wikipediaURL = try container.decodeIfPresent(String.self, forKey: .wikipediaURL)
        self.temperament = try container.decode(String.self, forKey: .temperament)
        self.origin = try container.decode(String.self, forKey: .origin)
        self.countryCode = try container.decode(String.self, forKey: .countryCode)
        self.catDescription = try container.decode(String.self, forKey: .catDescription)
        self.lifeSpan = try container.decode(String.self, forKey: .lifeSpan)
        self.indoor = try container.decode(Int.self, forKey: .indoor)
        self.lap = try container.decodeIfPresent(Int.self, forKey: .lap)
        self.altNames = try container.decodeIfPresent(String.self, forKey: .altNames)
        self.adaptability = try container.decode(Int.self, forKey: .adaptability)
        self.affectionLevel = try container.decode(Int.self, forKey: .affectionLevel)
        self.childFriendly = try container.decode(Int.self, forKey: .childFriendly)
        self.dogFriendly = try container.decode(Int.self, forKey: .dogFriendly)
        self.energyLevel = try container.decode(Int.self, forKey: .energyLevel)
        self.grooming = try container.decode(Int.self, forKey: .grooming)
        self.healthIssues = try container.decode(Int.self, forKey: .healthIssues)
        self.intelligence = try container.decode(Int.self, forKey: .intelligence)
        self.sheddingLevel = try container.decode(Int.self, forKey: .sheddingLevel)
        self.socialNeeds = try container.decode(Int.self, forKey: .socialNeeds)
        self.strangerFriendly = try container.decode(Int.self, forKey: .strangerFriendly)
        self.vocalisation = try container.decode(Int.self, forKey: .vocalisation)
        self.experimental = try container.decode(Int.self, forKey: .experimental)
        self.hairless = try container.decode(Int.self, forKey: .hairless)
        self.natural = try container.decode(Int.self, forKey: .natural)
        self.rare = try container.decode(Int.self, forKey: .rare)
        self.rex = try container.decode(Int.self, forKey: .rex)
        self.suppressedTail = try container.decode(Int.self, forKey: .suppressedTail)
        self.shortLegs = try container.decode(Int.self, forKey: .shortLegs)
        self.hypoallergenic = try container.decode(Int.self, forKey: .hypoallergenic)
        self.catFriendly = try container.decodeIfPresent(Int.self, forKey: .catFriendly)
        self.bidability = try container.decodeIfPresent(Int.self, forKey: .bidability)
        self.referenceImageID = try container.decodeIfPresent(String.self, forKey: .referenceImageID)
        self.image = try container.decodeIfPresent(CatImage.self, forKey: .image)
    }
    
    static func ==(lhs: CatBreed, rhs: CatBreed) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.weight == rhs.weight
            && lhs.cfaURL == rhs.cfaURL
            && lhs.vetstreetURL == rhs.vetstreetURL
            && lhs.vcahospitalsURL == rhs.vcahospitalsURL
            && lhs.wikipediaURL == rhs.wikipediaURL
            && lhs.temperament == rhs.temperament
            && lhs.origin == rhs.origin
            && lhs.countryCode == rhs.countryCode
            && lhs.catDescription == rhs.catDescription
            && lhs.lifeSpan == rhs.lifeSpan
            && lhs.indoor == rhs.indoor
            && lhs.lap == rhs.lap
            && lhs.altNames == rhs.altNames
            && lhs.adaptability == rhs.adaptability
            && lhs.affectionLevel == rhs.affectionLevel
            && lhs.childFriendly == rhs.childFriendly
            && lhs.dogFriendly == rhs.dogFriendly
            && lhs.energyLevel == rhs.energyLevel
            && lhs.grooming == rhs.grooming
            && lhs.healthIssues == rhs.healthIssues
            && lhs.intelligence == rhs.intelligence
            && lhs.sheddingLevel == rhs.sheddingLevel
            && lhs.socialNeeds == rhs.socialNeeds
            && lhs.strangerFriendly == rhs.strangerFriendly
            && lhs.vocalisation == rhs.vocalisation
            && lhs.experimental == rhs.experimental
            && lhs.hairless == rhs.hairless
            && lhs.natural == rhs.natural
            && lhs.rare == rhs.rare
            && lhs.rex == rhs.rex
            && lhs.suppressedTail == rhs.suppressedTail
            && lhs.shortLegs == rhs.shortLegs
            && lhs.hypoallergenic == rhs.hypoallergenic
            && lhs.catFriendly == rhs.catFriendly
            && lhs.bidability == rhs.bidability
            && lhs.referenceImageID == rhs.referenceImageID
            && lhs.image == rhs.image
    }
    
    // -- MARK: test object
    nonisolated(unsafe) static let test: CatBreed = CatBreed(
        id: "aege",
        name: "Aegean",
        weight: CatWeight(imperial: "7 - 10", metric: "3 - 5"),
        cfaURL: nil,
        vetstreetURL: nil,
        vcahospitalsURL: nil,
        wikipediaURL: nil,
        temperament: "Affectionate, Social, Intelligent, Playful, Active",
        origin: "Greece",
        countryCode: "GR",
        catDescription: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
        altNames: nil,
        lifeSpan: "9 - 12",
        indoor: 0,
        lap: 1,
        adaptability: 5,
        affectionLevel: 4,
        childFriendly: 4,
        dogFriendly: 4,
        energyLevel: 3,
        grooming: 3,
        healthIssues: 1,
        intelligence: 3,
        sheddingLevel: 3,
        socialNeeds: 4,
        strangerFriendly: 4,
        vocalisation: 3,
        experimental: 1,
        hairless: 1,
        natural: 1,
        rare: 0,
        rex: 0,
        suppressedTail: 0,
        shortLegs: 0,
        hypoallergenic: 0,
        catFriendly: 3,
        bidability: 4,
        referenceImageID: "ozEvzdVM-",
        image: CatImage(
            id: "ozEvzdVM-",
            url: "https://cdn2.thecatapi.com/images/ozEvzdVM-.jpg",
            width: 1200,
            height: 800
        )
    )
    
    

//    
//    // MARK: overriding default Equatable behaviour
//    public func isEqual(_ object: Any?) -> Bool {
//        guard object is CatBreed, let catBreed = object as? CatBreed else {
//            return false
//        }
//        // TODO: add other fields ???
//        return self.id == catBreed.id
//    }
//
}
