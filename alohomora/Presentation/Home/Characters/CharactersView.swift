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
        UIView.animate(withDuration: 0.25) {
            self.mainCarroussel.alpha = 0.0
        }

        addSubview(progressBar)
        progressBar.alpha = 0.0
        
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 8)
        ])

        layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25) {
            self.progressBar.alpha = 1.0
        }
    }

    func stopLoading() {
        UIView.animate(withDuration: 0.2, animations: {
            self.progressBar.alpha = 0.0
        }) { _ in
            self.progressBar.removeFromSuperview()
        }

        self.mainCarroussel.alpha = 1.0
    }
}
