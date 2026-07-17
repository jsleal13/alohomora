//
//  SpellbookView.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class SpellbookView: UIView {
    var spellsList: [Spell]?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Spellbook"
        label.font = UIFont(name: "Georgia-Bold", size: 32) ?? .systemFont(ofSize: 32, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressBar: ProgressBar = {
        let element = ProgressBar()
        element.gradientColors = [.systemRed, .systemYellow]
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { _, _ in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(100)
            )
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.register(SpellCell.self, forCellWithReuseIdentifier: SpellCell.identifier)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setElements() {
        addSubview(titleLabel)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setSpells(_ spells: [Spell]) {
        spellsList = spells
        collectionView.reloadData()
    }
    
    func startLoading() {
        UIView.animate(withDuration: 0.25) {
            self.collectionView.alpha = 0.0
        }

        addSubview(progressBar)
        progressBar.alpha = 0.0
        
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
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

        self.collectionView.alpha = 1.0
    }
}

extension SpellbookView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        spellsList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let spellsList else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpellCell.identifier, for: indexPath) as! SpellCell
        
        cell.configure(with: spellsList[indexPath.item])
        return cell
    }
}
