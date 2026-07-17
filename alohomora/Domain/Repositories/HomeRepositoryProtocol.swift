//
//  HomeRepositoryProtocol.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

protocol HomeRepositoryProtocol {
    func fetchCharacters() async throws -> [Character]
    func fetchCharacter(id: String) async throws -> Character?
    func fetchCharacters(house: String) async throws -> [Character]
}
