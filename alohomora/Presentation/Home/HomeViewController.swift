//
//  HomeViewController.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeViewController: BaseViewController {
    let mainView = HomeView()

    override func loadView() {
        super.loadView()
        view = mainView
    }
}
