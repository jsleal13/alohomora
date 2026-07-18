//
//  CharacterRequest.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

enum CharacterRequest: RequestInfos {
    case all
    case byId(id: String)
    case byHouse(house: String)

    var endpoint: String {
        switch self {
        case .all:
            return "characters"
        case .byId(let id):
            return "character/\(id)"
        case .byHouse(let house):
            return "characters/house/\(house)"
        }
    }
}
