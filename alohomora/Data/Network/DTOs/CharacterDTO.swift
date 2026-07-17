//
//  CharacterDTO.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

struct CharacterDTO: Decodable {
    let id: String
    let name: String
    let species: String
    let dateOfBirth: String?
    let alive: Bool
    let image: String
    let wand: WandDTO?
    let house: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case species
        case dateOfBirth
        case alive
        case image
        case wand
        case house
    }
    
    func toDomain() -> Character? {
        guard let url = URL(string: image) else { return nil }

        return Character(
            id: id,
            name: name,
            species: species,
            dateOfBirth: dateOfBirth,
            alive: alive,
            image: url,
            wand: Wand(wood: wand?.wood, core: wand?.core, length: wand?.length),
            isFavorite: false,
            house: House(named: house)
        )
    }
}

struct WandDTO: Decodable {
    let wood: String?
    let core: String?
    let length: Double?
    
    enum CodingKeys: CodingKey {
        case wood
        case core
        case length
    }
}
