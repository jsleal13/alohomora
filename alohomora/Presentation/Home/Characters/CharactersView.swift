//
//  CharactersView.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class CharactersView: UIView {
    private lazy var progressBar: ProgressBar = {
        let element = ProgressBar()
        element.gradientColors = [.systemRed, .systemYellow]
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Main Characters"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var mainCarroussel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 180)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let element = UICollectionView(frame: frame, collectionViewLayout: layout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
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
            title.topAnchor.constraint(equalTo: topAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor),
            title.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCarroussel.topAnchor.constraint(equalTo: title.bottomAnchor),
            mainCarroussel.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCarroussel.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainCarroussel.heightAnchor.constraint(equalToConstant: 200),
            mainCarroussel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        mainCarroussel.isHidden = true
        addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func stopLoading() {
        progressBar.removeFromSuperview()
        mainCarroussel.isHidden = false
    }
}
