//
//  HomeFactory.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class HomeFactory {
    static func make() -> UIViewController {
        let repository = HomeRepository()
        let fetchCharactersUseCase = FetchMainCharactersUseCase(repository: repository)
        let viewModel = HomeViewModel(useCase: fetchCharactersUseCase)
        let viewController = HomeViewController(viewModel: viewModel)

        return viewController
    }
}
