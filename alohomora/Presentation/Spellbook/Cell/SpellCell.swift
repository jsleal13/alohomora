//
//  SpellCell.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class SpellCell: UICollectionViewCell {
    static let identifier = "SpellCell"
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.13, green: 0.13, blue: 0.16, alpha: 1.0)
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia-Bold", size: 18) ?? .systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 0.93, green: 0.73, blue: 0.21, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        containerView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16)
        ])
    }
}
