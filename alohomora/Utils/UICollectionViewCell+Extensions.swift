//
//  UICollectionViewCell+Extensions.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

extension UICollectionViewCell {
    func animateFavoriteFeedback(isAdding: Bool, completion: (() -> Void)? = nil) {
        let imageName = isAdding ? "heart.fill" : "heart.slash.fill"
        let iconColor = isAdding ? UIColor(red: 0.93, green: 0.73, blue: 0.21, alpha: 1.0) : UIColor.systemRed
        
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .bold)
        imageView.image = UIImage(systemName: imageName, withConfiguration: config)
        imageView.tintColor = iconColor
        imageView.alpha = 0.0
        
        imageView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        

        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
        contentView.layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.8,
            options: [],
            animations: {
                imageView.alpha = 1.0
                imageView.transform = .identity
            }
        ) { _ in
            UIView.animate(withDuration: 0.2, delay: 0.3, options: .curveEaseOut, animations: {
                imageView.alpha = 0.0
                imageView.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
            }) { _ in
                imageView.removeFromSuperview()
                completion?()
            }
        }
    }
}
