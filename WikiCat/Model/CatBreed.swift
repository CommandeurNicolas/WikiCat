//
//  CatBreed.swift
//  WikiCat
//
//  Created by Nicolas Commandeur on 15/01/2023.
//

import Foundation
import RealmSwift

class CatBreed: Object, Identifiable, Codable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var weight: CatWeight?
    @Persisted var name: String
    @Persisted var cfa_url: String?
    @Persisted var vetstreet_url: String?
    @Persisted var vcahospitals_url: String?
    @Persisted var wikipedia_url: String?
    @Persisted var temperament: String?
    @Persisted var origin: String
    //    let country_codes: String
    @Persisted var country_code: String
    @Persisted var breedDescription: String
    @Persisted var life_span: String?
    @Persisted var alt_names: String?
    
    @Persisted private var experimental: Int?
    var isExperimental: Bool {
        return experimental == 1
    }
    @Persisted private var hairless: Int?
    var isHairless: Bool {
        return hairless == 1
    }
    @Persisted private var natural: Int?
    var isNatural: Bool {
        return natural == 1
    }
    @Persisted private var rare: Int?
    var isRare: Bool {
        return rare == 1
    }
    @Persisted private var rex: Int?
    var isRex: Bool {
        return rex == 1
    }
    @Persisted private var suppressed_tail: Int?
    var hasSuppressedTail: Bool {
        return suppressed_tail == 1
    }
    @Persisted private var short_legs: Int?
    var hasShortLegs: Bool {
        return short_legs == 1
    }
    @Persisted private var hypoallergenic: Int?
    var isHypoallergenic: Bool {
        return hypoallergenic == 1
    }
    
    
    // Star levels
    @Persisted var indoor: Int?
    @Persisted var lap: Int?
    @Persisted var adaptability: Int?
    @Persisted var affection_level: Int?
    @Persisted var child_friendly: Int?
    @Persisted var dog_friendly: Int?
    @Persisted var energy_level: Int?
    @Persisted var grooming: Int?
    @Persisted var health_issues: Int?
    @Persisted var intelligence: Int?
    @Persisted var shedding_level: Int?
    @Persisted var social_needs: Int?
    @Persisted var stranger_friendly: Int?
    @Persisted var vocalisation: Int?
    
    // Image
    @Persisted var reference_image_id: String?
    @Persisted var image: CatImage?
    
    var hasAttributes: Bool {
        return isExperimental
        || isHairless
        || isNatural
        || isRare
        || isRex
        || hasSuppressedTail
        || hasShortLegs
        || isHypoallergenic
    }
    var hasTemperament: Bool {
        return temperament == nil ? false : !(temperament!.isEmpty)
    }
    @Persisted var isFavorite: Bool = false
    
    
    // -- MARK: Initializer
    override init() { super.init() }
    init(
        id: String,
        weight: CatWeight?,
        name: String,
        cfa_url: String?,
        vetstreet_url: String?,
        vcahospitals_url: String?,
        wikipedia_url: String?,
        temperament: String?,
        origin: String,
        country_code: String,
        breedDescription: String,
        life_span: String?,
        alt_names: String?,
        experimental: Int?,
        hairless: Int?,
        natural: Int?,
        rare: Int?,
        rex: Int?,
        suppressed_tail: Int?,
        short_legs: Int?,
        hypoallergenic: Int?,
        indoor: Int?,
        lap: Int?,
        adaptability: Int?,
        affection_level: Int?,
        child_friendly: Int?,
        dog_friendly: Int?,
        energy_level: Int?,
        grooming: Int?,
        health_issues: Int?,
        intelligence: Int?,
        shedding_level: Int?,
        social_needs: Int?,
        stranger_friendly: Int?,
        vocalisation: Int?,
        reference_image_id: String?,
        image: CatImage?
    ) {
        super.init()
        self.id = id
        self.weight = weight
        self.name = name
        self.cfa_url = cfa_url
        self.vetstreet_url = vetstreet_url
        self.vcahospitals_url = vcahospitals_url
        self.wikipedia_url = wikipedia_url
        self.temperament = temperament
        self.origin = origin
        self.country_code = country_code
        self.breedDescription = breedDescription
        self.life_span = life_span
        self.alt_names = alt_names
        self.experimental = experimental
        self.hairless = hairless
        self.natural = natural
        self.rare = rare
        self.rex = rex
        self.suppressed_tail = suppressed_tail
        self.short_legs = short_legs
        self.hypoallergenic = hypoallergenic
        self.indoor = indoor
        self.lap = lap
        self.adaptability = adaptability
        self.affection_level = affection_level
        self.child_friendly = child_friendly
        self.dog_friendly = dog_friendly
        self.energy_level = energy_level
        self.grooming = grooming
        self.health_issues = health_issues
        self.intelligence = intelligence
        self.shedding_level = shedding_level
        self.social_needs = social_needs
        self.stranger_friendly = stranger_friendly
        self.vocalisation = vocalisation
        self.reference_image_id = reference_image_id
        self.image = image
    }
    
    required init(from decoder:Decoder) throws {
        super.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.weight = try? values.decode(CatWeight.self, forKey: .weight)
        self.name = try values.decode(String.self, forKey: .name)
        self.cfa_url = try? values.decode(String.self, forKey: .cfa_url)
        self.vetstreet_url = try? values.decode(String.self, forKey: .vetstreet_url)
        self.vcahospitals_url = try? values.decode(String.self, forKey: .vcahospitals_url)
        self.wikipedia_url = try? values.decode(String.self, forKey: .wikipedia_url)
        self.temperament = try? values.decode(String.self, forKey: .temperament)
        self.origin = try values.decode(String.self, forKey: .origin)
        self.country_code = try values.decode(String.self, forKey: .country_code)
        self.breedDescription = try values.decode(String.self, forKey: .breedDescription)
        self.life_span = try? values.decode(String.self, forKey: .life_span)
        self.alt_names = try? values.decode(String.self, forKey: .alt_names)
        self.experimental = try? values.decode(Int.self, forKey: .experimental)
        self.hairless = try? values.decode(Int.self, forKey: .hairless)
        self.natural = try? values.decode(Int.self, forKey: .natural)
        self.rare = try? values.decode(Int.self, forKey: .rare)
        self.rex = try? values.decode(Int.self, forKey: .rex)
        self.suppressed_tail = try? values.decode(Int.self, forKey: .suppressed_tail)
        self.short_legs = try? values.decode(Int.self, forKey: .short_legs)
        self.hypoallergenic = try? values.decode(Int.self, forKey: .hypoallergenic)
        self.indoor = try? values.decode(Int.self, forKey: .indoor)
        self.lap = try? values.decode(Int.self, forKey: .lap)
        self.adaptability = try? values.decode(Int.self, forKey: .adaptability)
        self.affection_level = try? values.decode(Int.self, forKey: .affection_level)
        self.child_friendly = try? values.decode(Int.self, forKey: .child_friendly)
        self.dog_friendly = try? values.decode(Int.self, forKey: .dog_friendly)
        self.energy_level = try? values.decode(Int.self, forKey: .energy_level)
        self.grooming = try? values.decode(Int.self, forKey: .grooming)
        self.health_issues = try? values.decode(Int.self, forKey: .health_issues)
        self.intelligence = try? values.decode(Int.self, forKey: .intelligence)
        self.shedding_level = try? values.decode(Int.self, forKey: .shedding_level)
        self.social_needs = try? values.decode(Int.self, forKey: .social_needs)
        self.stranger_friendly = try? values.decode(Int.self, forKey: .stranger_friendly)
        self.vocalisation = try? values.decode(Int.self, forKey: .vocalisation)
        self.reference_image_id = try? values.decode(String.self, forKey: .reference_image_id)
        self.image = try? values.decode(CatImage.self, forKey: .image)
    }
    
    private enum CodingKeys: String, CodingKey {
        case breedDescription = "description"
        case id, weight, name, cfa_url, vetstreet_url, vcahospitals_url, wikipedia_url, temperament, origin, country_code, life_span, alt_names, experimental, hairless, natural, rare, rex, suppressed_tail, short_legs, hypoallergenic, indoor, lap, adaptability, affection_level, child_friendly, dog_friendly, energy_level, grooming, health_issues, intelligence, shedding_level, social_needs, stranger_friendly, vocalisation, reference_image_id, image
    }
    
    // MARK: overriding default Equatable behaviour
    public override func isEqual(_ object: Any?) -> Bool {
        guard object is CatBreed, let catBreed = object as? CatBreed else {
            return false
        }
        // TODO: add other fields ???
        return self.id == catBreed.id
    }
    
    // -- MARK: test object
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
        breedDescription: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
        life_span: "9 - 12",
        alt_names: "",
        experimental: 1,
        hairless: 1,
        natural: 1,
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
