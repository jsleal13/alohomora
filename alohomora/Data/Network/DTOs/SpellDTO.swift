//
//  SpellDTO.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

struct SpellDTO: Decodable {
    let id: String
    let name: String
    let description: String

    enum CodingKeys: CodingKey {
        case id
        case name
        case description
    }
}
