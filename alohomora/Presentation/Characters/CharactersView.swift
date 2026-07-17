//
//  CharactersView.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class CharactersView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Main Characters"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainCarroussel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 54)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let element = UICollectionView(frame: frame, collectionViewLayout: layout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.register(CharacterCell.self, forCellWithReuseIdentifier: "CharacterCell")
        return element
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElements()
    }

    private func setElements() {
        addSubview(title)
        addSubview(mainCarroussel)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCarroussel.topAnchor.constraint(equalTo: title.bottomAnchor),
            mainCarroussel.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCarroussel.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCarroussel.heightAnchor.constraint(equalToConstant: 54)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
