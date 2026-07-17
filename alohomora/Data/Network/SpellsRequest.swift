//
//  SpellsRequest.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import Foundation

enum SpellsRequest: RequestInfos {
    case getAll

    var endpoint: String {
        switch self {
        case .getAll: "spells"
        }
    }
}
