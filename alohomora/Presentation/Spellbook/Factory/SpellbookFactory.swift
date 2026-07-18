//
//  SpellbookFactory.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class SpellbookFactory {
    static func make() -> UIViewController {
        let favoriteReository = UserDefaultsFavoritesRepository()
        let toggleFavorite = ToggleSpellFavoriteUseCase(repository: favoriteReository)
        let repository = SpellsRepository()
        let fetchSpellsUseCase = FetchSpellsUseCase(repository: repository)
        let viewModel = SpellbookViewModel(fetchSpellsUseCase: fetchSpellsUseCase, toggleFavorite: toggleFavorite)
        let viewController = SpellbookViewController(viewModel: viewModel)

        return viewController
    }
}
