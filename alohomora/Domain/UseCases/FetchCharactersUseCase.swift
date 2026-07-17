//
//  FetchCharactersUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import Foundation

protocol FetchAllCharactersUseCaseProtocol {
    func execute() async throws -> [Character]
}

final class FetchAllCharactersUseCase: FetchAllCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) { self.repository = repository }
    
    func execute() async throws -> [Character] {
        return try await repository.fetchCharacters()
    }
}

protocol FetchMainCharactersUseCaseProtocol {
    func execute() async throws -> [Character]
}

final class FetchMainCharactersUseCase: FetchMainCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) { self.repository = repository }
    
    func execute() async throws -> [Character] {
        let allCharacters = try await repository.fetchCharacters()
        
        return Array(allCharacters.prefix(10))
    }
}

protocol FetchCharactersByHouseUseCaseProtocol {
    func execute(house: String) async throws -> [Character]
}

final class FetchCharactersByHouseUseCase: FetchCharactersByHouseUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) { self.repository = repository }
    
    func execute(house: String) async throws -> [Character] {
        return try await repository.fetchCharacters(house: house)
    }
}

protocol FetchCharacterDetailsUseCaseProtocol {
    func execute(id: String) async throws -> Character?
}

final class FetchCharacterDetailsUseCase: FetchCharacterDetailsUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol

    init(repository: CharacterRepositoryProtocol) { self.repository = repository }
    
    func execute(id: String) async throws -> Character? {
        return try await repository.fetchCharacter(id: id)
    }
}
