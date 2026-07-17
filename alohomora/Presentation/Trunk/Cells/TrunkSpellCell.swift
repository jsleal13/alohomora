//
//  TrunkSpellCell.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class TrunkSpellCell: UICollectionViewCell {
    static let identifier = "TrunkSpellCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 1.0)
        view.layer.cornerRadius = 14
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var spellIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wand.and.stars")
        imageView.tintColor = UIColor(red: 0.93, green: 0.73, blue: 0.21, alpha: 1.0)
        imageView.contentMode = .center
        imageView.backgroundColor = UIColor(red: 0.18, green: 0.18, blue: 0.22, alpha: 1.0)
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia-Bold", size: 16) ?? .systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor(red: 0.93, green: 0.73, blue: 0.21, alpha: 1.0)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with spell: Spell) {
        nameLabel.text = spell.name
        descriptionLabel.text = spell.description
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(spellIconView)
        containerView.addSubview(textStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            spellIconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            spellIconView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            spellIconView.widthAnchor.constraint(equalTo: spellIconView.heightAnchor),
            spellIconView.heightAnchor.constraint(equalToConstant: 50),
            
            textStackView.leadingAnchor.constraint(equalTo: spellIconView.trailingAnchor, constant: 16),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            textStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            textStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
