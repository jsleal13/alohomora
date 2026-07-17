//
//  FetchFavoriteCharactersUseCase.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

protocol FetchFavoriteCharactersUseCaseProtocol {
    func execute() async throws -> [Character]
}

final class FetchFavoriteCharactersUseCase: FetchFavoriteCharactersUseCaseProtocol {
    private let characterRepository: CharacterRepositoryProtocol
    private let favoritesRepository: FavoritesRepositoryProtocol
    
    init(characterRepository: CharacterRepositoryProtocol, favoritesRepository: FavoritesRepositoryProtocol) {
        self.characterRepository = characterRepository
        self.favoritesRepository = favoritesRepository
    }
    
    func execute() async throws -> [Character] {
        let allCharacters = try await characterRepository.fetchCharacters()
        
        let favoriteIds = favoritesRepository.getFavorites(for: .character)
        
        let favoriteCharacters = allCharacters.filter { character in
            favoriteIds.contains(character.id)
        }
        
        return favoriteCharacters
    }
}
