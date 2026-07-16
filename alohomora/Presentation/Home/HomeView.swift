//
//  HomeView.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeView: UIView {
    private lazy var mainStack: UIStackView = {
        let element = UIStackView(
            arrangedSubviews: [
                title,
                subtitle,
                housesView,
                charactersView
            ]
        )
        element.translatesAutoresizingMaskIntoConstraints = false
        element.axis = .vertical
        return element
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Alohomora!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Bom dia, bruxo(a)"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var housesView: HousesView = {
        let housesView = HousesView()
        housesView.translatesAutoresizingMaskIntoConstraints = false
        return housesView
    }()
    
    private lazy var charactersView: MainCharactersView = {
        let element = MainCharactersView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElements()
    }
    
    private func setElements() {
        addSubview(mainStack)
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
