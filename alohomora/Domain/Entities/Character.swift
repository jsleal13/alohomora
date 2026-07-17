//
//  Character.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

struct Character {
    let id: String
    let name: String
    let species: String
    let dateOfBirth: String?
    let alive: Bool
    let image: URL
    let wand: Wand?
    let isFavorite: Bool
    let house: House?
}

struct Wand {
    let wood: String?
    let core: String?
    let length: Double?
}
