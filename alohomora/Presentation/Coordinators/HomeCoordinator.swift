//
//  HomeCoordinator.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeVC = HomeFactory.make()
        navigationController.setViewControllers([homeVC], animated: false)
    }
}
