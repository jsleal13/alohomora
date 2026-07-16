//
//  CharacterCell.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont(name: "Rockwell", size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [photoImageView, nameLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        return stack
    }()

    private var imageTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor)
        ])

        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.borderWidth = 4

        photoImageView.layer.cornerRadius = 8
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageTask?.cancel()
        imageTask = nil
        photoImageView.image = nil
    }

    func setUp(with character: Character) {
        nameLabel.text = character.name
        backgroundColor = character.house.color
        layer.borderColor = character.house.color.grayedOut().cgColor
        nameLabel.textColor = character.house.secondaryColor

        imageTask = ImageLoader.shared.loadImage(from: character.photoURL) { [weak self] image in
            self?.photoImageView.image = image
        }
    }
}
