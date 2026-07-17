//
//  HomeTabBarViewController.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

class HomeTabBarController: UITabBarController, UITableViewDelegate, UICollectionViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.tintColor = .white
        tabBar.isTranslucent = true

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = .clear
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance

        let navAppearance = UINavigationBarAppearance()
        navAppearance.configureWithOpaqueBackground()
        navAppearance.backgroundColor = .clear
        UINavigationBar.appearance().standardAppearance = navAppearance
        UINavigationBar.appearance().compactAppearance = navAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navAppearance
    }
}
