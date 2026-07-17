//
//  ToggleFavoriteUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol ToggleFavoriteUseCaseProtocol {
    func execute(characterId: String)
}

final class ToggleFavoriteUseCase: ToggleFavoriteUseCaseProtocol {
    private let repository: FavoritesRepositoryProtocol

    init(repository: FavoritesRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(characterId: String) {
        repository.toggleFavorite(id: characterId)
    }
}
