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
        let viewModel = TrunkViewModel(fetchSpellsUseCase: fetchFavoriteSpellsUseCase, fetchCharactersUseCase: fetchFavoriteCharactersUseCase)
        let viewController = TrunkViewController(viewModel: viewModel)

        return viewController
    }
}
