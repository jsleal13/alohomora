//
//  ToggleFavoriteUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol ToggleCharacterFavoriteUseCaseProtocol {
    func packInTrunk(_ characterId: String)
    func checkIfIsFavorite(_ characterId: String) -> Bool
}

protocol ToggleSpellFavoriteUseCaseProtocol {
    func packInTrunk(_ spellId: String)
    func checkIfIsFavorite(_ spellId: String) -> Bool
}

final class ToggleCharacterFavoriteUseCase: ToggleCharacterFavoriteUseCaseProtocol{
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func packInTrunk(_ characterId: String) {
        repository.toggleFavorite(id: characterId, type: .character)
    }
    
    func checkIfIsFavorite(_ characterId: String) -> Bool {
        repository.isFavorite(id: characterId, type: .character)
    }
}

final class ToggleSpellFavoriteUseCase: ToggleSpellFavoriteUseCaseProtocol {
    private let repository: FavoritesRepositoryProtocol
    
    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func packInTrunk(_ spellId: String) {
        repository.toggleFavorite(id: spellId, type: .spell)
    }
    
    func checkIfIsFavorite(_ spellId: String) -> Bool {
        repository.isFavorite(id: spellId, type: .spell)
    }
}

enum FavoriteType: String {
    case character = "favorite_characters"
    case spell = "favorite_spells"
}
