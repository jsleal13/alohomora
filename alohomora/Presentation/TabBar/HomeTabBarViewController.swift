//
//  HomeTabBarViewController.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

class HomeTabBarViewController: UITabBarController, UITableViewDelegate, UICollectionViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .blue
        tabBar.isTranslucent = false

        let controllers = [
            buildHome(),
            buildSaved(),
            buildDownloaded(),
            buildSearch()
        ]

        viewControllers = controllers.map { UINavigationController(rootViewController: $0)}

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .gray
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance

        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }

    func buildHome() -> UIViewController {
        let homeViewController = HomeViewController(viewModel: CharactersViewModel())
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: .init(systemName: "house"), tag: 0)

        return homeViewController
    }

    func buildSaved() -> UIViewController {
        let comingSoonController = UIViewController()
        comingSoonController.tabBarItem = UITabBarItem(title: "Favorite", image: .init(systemName: "heart.fill"), tag: 1)

        return comingSoonController
    }

    func buildDownloaded() -> UIViewController {
        let downloadedController = UIViewController()
        downloadedController.tabBarItem = UITabBarItem(title: "Downloaded", image: .init(systemName: "arrow.down.circle.fill"), tag: 2)

        return downloadedController
    }

    func buildSearch() -> UIViewController {
        let searchController = UIViewController()
        searchController.tabBarItem = UITabBarItem(title: "Search", image: .init(systemName: "magnifyingglass"), tag: 3)

        return searchController
    }
}
