//
//  HouseCell.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class HouseCell: UICollectionViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Rockwell", size: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.borderWidth = 4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp(with house: House) {
        nameLabel.text = house.name
        backgroundColor = UIColor(hex: house.primaryColorHex)
        layer.borderColor = UIColor(hex: house.secondaryColorHex)?.cgColor
        nameLabel.textColor = UIColor(hex: house.secondaryColorHex)
    }
}
