//
//  FetchSpellsUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

protocol FetchSpellsUseCaseProtocol {
    func execute() async throws -> [Spell]
}

final class FetchSpellsUseCase: FetchSpellsUseCaseProtocol {
    private let repository: SpellsRepositoryProtocol

    init(repository: SpellsRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [Spell] {
        return try await repository.fetchSpells()
    }
}
