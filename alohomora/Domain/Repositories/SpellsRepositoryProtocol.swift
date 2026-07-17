//
//  SpellsRepositoryProtocol.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

protocol SpellsRepositoryProtocol {
    func fetchSpells() async throws -> [Spell]
}
