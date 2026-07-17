//
//  HousesView.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class HousesView: UIView {
    private let housesList: [House] = [
        House.gryffindor,
        House.hufflepuff,
        House.ravenclaw,
        House.slytherin
    ]

    private lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Hogwarts House's"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainCarroussel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 54)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        let element = UICollectionView(frame: frame, collectionViewLayout: layout)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsHorizontalScrollIndicator = false
        element.register(HouseCell.self, forCellWithReuseIdentifier: "HouseCell")
        element.delegate = self
        element.dataSource = self
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

extension HousesView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return housesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HouseCell", for: indexPath) as! HouseCell
        let house = housesList[indexPath.item]
        cell.setUp(with: house)
        return cell
    }
}
