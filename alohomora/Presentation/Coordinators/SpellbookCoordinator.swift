//
//  SpellbookCoordinator.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class SpellbookCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let spellbookVC = SpellbookFactory.make()
        navigationController.setViewControllers([spellbookVC], animated: false)
    }
}
