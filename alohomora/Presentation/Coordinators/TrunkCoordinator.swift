//
//  TrunkCoordinator.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class TrunkCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let trunkVC = TrunkFactory.make()
        navigationController.setViewControllers([trunkVC], animated: false)
    }
}
