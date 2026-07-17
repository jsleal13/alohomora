//
//  HomeFactory.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class HomeFactory {
    static func make() -> UIViewController {
        let repository = CharacterRepository()
        let favoriteReository = UserDefaultsFavoritesRepository()
        let fetchMainCharactersUseCase = FetchMainCharactersUseCase(repository: repository)
        let fetchCharactersByHouseUseCase = FetchCharactersByHouseUseCase(repository: repository)
        let toggleFavorite = ToggleCharacterFavoriteUseCase(repository: favoriteReository)
        let viewModel = HomeViewModel(
            mainCharactersUseCase: fetchMainCharactersUseCase,
            charactersByHouseUseCase: fetchCharactersByHouseUseCase
        )
        let viewController = HomeViewController(viewModel: viewModel, toggleFavorite: toggleFavorite)

        return viewController
    }
}
