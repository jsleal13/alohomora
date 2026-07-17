//
//  SortingHatCoordinator.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class SortingHatCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
}
