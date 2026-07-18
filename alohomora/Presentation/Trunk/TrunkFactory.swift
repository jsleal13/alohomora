//
//  TrunkFactory.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class TrunkFactory {
    static func make() -> UIViewController {
        let favoriteReository = UserDefaultsFavoritesRepository()
        let spellsRepository = SpellsRepository()
        let characterRepository = CharacterRepository()

        let fetchFavoriteSpellsUseCase = FetchFavoriteSpellsUseCase(spellsRepository: spellsRepository, favoritesRepository: favoriteReository)
        let fetchFavoriteCharactersUseCase = FetchFavoriteCharactersUseCase(characterRepository: characterRepository, favoritesRepository: favoriteReository)
        let toggleFavoriteSpells = ToggleSpellFavoriteUseCase(repository: favoriteReository)
        let toggleFavoriteCharacter = ToggleCharacterFavoriteUseCase(repository: favoriteReository)

        let viewModel = TrunkViewModel(
            fetchSpellsUseCase: fetchFavoriteSpellsUseCase,
            fetchCharactersUseCase: fetchFavoriteCharactersUseCase,
            toggleFavoriteCharacter: toggleFavoriteCharacter,
            toggleFavoriteSpell: toggleFavoriteSpells
        )
        let viewController = TrunkViewController(viewModel: viewModel)

        return viewController
    }
}
