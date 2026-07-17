//
//  TabBarCoordinator.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = HomeTabBarController()

        let homeCoordinator = HomeCoordinator(navigationController: UINavigationController())
        let sortingHatCoordinator = SortingHatCoordinator(navigationController: UINavigationController())
        let spellbookCoordinator = SpellbookCoordinator(navigationController: UINavigationController())
        let trunkCoordinator = TrunkCoordinator(navigationController: UINavigationController())
        
        childCoordinators = [homeCoordinator, spellbookCoordinator, trunkCoordinator, sortingHatCoordinator]
        
        childCoordinators.forEach { $0.start() }
        
        homeCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Home", image: UIImage(systemName: "house"), tag: 0
        )
        spellbookCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Spellbook", image: UIImage(systemName: "book"), tag: 1
        )
        trunkCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Trunk", image: UIImage(systemName: "bag"), tag: 2
        )
        sortingHatCoordinator.navigationController.tabBarItem = UITabBarItem(
            title: "Sorting hat", image: UIImage(systemName: "wand.and.stars"), tag: 3
        )
        
        tabBarController.viewControllers = childCoordinators.map { $0.navigationController }
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
