//
//  HomeView.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeView: UIView {
    private lazy var tabBar: UITabBar = {
        let tabBar = UITabBar()
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElements()
    }
    
    private func setElements() {
        addSubview(tabBar)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
