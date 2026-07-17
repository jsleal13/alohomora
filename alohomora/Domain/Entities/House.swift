//
//  House.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

struct House {
    let name: String
    let primaryColorHex: String
    let secondaryColorHex: String
}

extension House {
    private enum Kind: String {
        case gryffindor
        case slytherin
        case hufflepuff
        case ravenclaw
    }

    init?(named name: String) {
        let normalized = name.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        guard let kind = Kind(rawValue: normalized) else { return nil }

        switch kind {
        case .gryffindor: self = .gryffindor
        case .slytherin: self = .slytherin
        case .hufflepuff: self = .hufflepuff
        case .ravenclaw: self = .ravenclaw
        }
    }
}

extension House {
    static let gryffindor = House(
        name: "Gryffindor",
        primaryColorHex: "#BC1E1E",
        secondaryColorHex: "#D9AB21"
    )

    static let slytherin = House(
        name: "Slytherin",
        primaryColorHex: "#1C5C38",
        secondaryColorHex: "#AEB5B6"
    )

    static let hufflepuff = House(
        name: "Hufflepuff",
        primaryColorHex: "#ECCA16",
        secondaryColorHex: "#191717"
    )

    static let ravenclaw = House(
        name: "Ravenclaw",
        primaryColorHex: "#041C57",
        secondaryColorHex: "#996633"
    )
}
