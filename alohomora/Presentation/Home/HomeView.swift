//
//  HomeView.swift
//  alohomora
//
//  Created by Janine Leal on 14/07/26.
//

import UIKit

final class HomeView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Alohomora!"
        label.font = .systemFont(ofSize: 34, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Bom dia, bruxo(a)"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var housesView: HousesView = {
        let housesView = HousesView()
        housesView.translatesAutoresizingMaskIntoConstraints = false
        return housesView
    }()
    
    lazy var charactersView: CharactersView = {
        let element = CharactersView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElements()
    }
    
    private func setElements() {
        addSubview(title)
        addSubview(subtitle)
        addSubview(housesView)
        addSubview(charactersView)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 16),
            subtitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            subtitle.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            housesView.topAnchor.constraint(equalTo: subtitle.bottomAnchor, constant: 64),
            housesView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            housesView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            charactersView.topAnchor.constraint(equalTo: housesView.bottomAnchor, constant: 16),
            charactersView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            charactersView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
