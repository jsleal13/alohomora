//
//  FetchFavoriteSpellsUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol FetchFavoriteSpellsUseCaseProtocol {
    func execute() async throws -> [Spell]
}

final class FetchFavoriteSpellsUseCase: FetchFavoriteSpellsUseCaseProtocol {
    private let spellsRepository: SpellsRepositoryProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol
    
    init(spellsRepository: SpellsRepositoryProtocol, favoritesRepository: FavoritesRepositoryProtocol) {
        self.spellsRepository = spellsRepository
        self.favoritesRepository = favoritesRepository
    }
    
    func execute() async throws -> [Spell] {
        let allSpells = try await spellsRepository.fetchSpells()
        
        let favoriteIds = favoritesRepository.getFavorites(for: .spell)
        
        return allSpells.filter { favoriteIds.contains($0.id) }
    }
}
