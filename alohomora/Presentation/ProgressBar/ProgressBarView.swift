//
//  ProgressBarView.swift
//  alohomora
//
//  Created by Janine Leal on 17/07/26.
//

import UIKit

final class ProgressBar: UIView {
    private let trackLayer = CAShapeLayer()
    private let containerLayer = CALayer()
    private let progressLayer = CAGradientLayer()
    private let progressShape = CAShapeLayer()
    private let shimmerLayer = CAGradientLayer()
    
    private let barHeight: CGFloat = 8
    private let ghostWidthRatio: CGFloat = 0.3
    
    var gradientColors: [UIColor] = [.systemYellow, .systemOrange] {
        didSet {
            progressLayer.colors = gradientColors.map { $0.cgColor }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    private func setupLayers() {
        translatesAutoresizingMaskIntoConstraints = false
        
        trackLayer.fillColor = UIColor.systemGray5.cgColor
        layer.addSublayer(trackLayer)
        
        layer.addSublayer(containerLayer)
        
        progressShape.fillColor = UIColor.black.cgColor
        containerLayer.mask = progressShape
        
        progressLayer.colors = gradientColors.map { $0.cgColor }
        progressLayer.startPoint = CGPoint(x: 0, y: 0.5)
        progressLayer.endPoint = CGPoint(x: 1, y: 0.5)
        containerLayer.addSublayer(progressLayer)
        
        shimmerLayer.colors = [
            UIColor.white.withAlphaComponent(0).cgColor,
            UIColor.white.withAlphaComponent(0.55).cgColor,
            UIColor.white.withAlphaComponent(0).cgColor
        ]
        shimmerLayer.startPoint = CGPoint(x: 0, y: 0.5)
        shimmerLayer.endPoint = CGPoint(x: 1, y: 0.5)
        containerLayer.addSublayer(shimmerLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let barRect = CGRect(x: 0, y: (bounds.height - barHeight) / 2, width: bounds.width, height: barHeight)
        
        trackLayer.frame = barRect
        trackLayer.path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: barRect.size), cornerRadius: barHeight / 2).cgPath
        
        containerLayer.frame = barRect
        progressLayer.frame = containerLayer.bounds
        shimmerLayer.frame = containerLayer.bounds
        
        updateGhostPath()

        if progressShape.animation(forKey: "indeterminateSlide") != nil {
            startShimmerAnimation()
            startIndeterminateAnimation()
        }
    }
    
    private func updateGhostPath() {
        let ghostWidth = bounds.width * ghostWidthRatio
        progressShape.path = UIBezierPath(
            roundedRect: CGRect(x: 0, y: 0, width: ghostWidth, height: barHeight),
            cornerRadius: barHeight / 2
        ).cgPath
    }
    
    private func startShimmerAnimation() {
        shimmerLayer.removeAnimation(forKey: "shimmerSlide")

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.duration = 1.4
        animation.repeatCount = .infinity
        shimmerLayer.add(animation, forKey: "shimmerSlide")
    }
    
    private func startIndeterminateAnimation() {
        progressShape.removeAnimation(forKey: "indeterminateSlide")
        
        let ghostWidth = bounds.width * ghostWidthRatio
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.fromValue = -ghostWidth
        animation.toValue = bounds.width
        animation.duration = 1.1
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        progressShape.add(animation, forKey: "indeterminateSlide")
    }
    
    // MARK: - Controle de Estado Avançado
    func startLoading(in containerView: UIView, fadingOut contentView: UIView?) {
        if let contentView = contentView {
            UIView.animate(withDuration: 0.25) {
                contentView.alpha = 0.0
            }
        }

        containerView.addSubview(self)
        self.alpha = 0.0

        NSLayoutConstraint.activate([
            self.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            self.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 32),
            self.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            self.heightAnchor.constraint(equalToConstant: barHeight)
        ])

        containerView.layoutIfNeeded()
        
        startShimmerAnimation()
        startIndeterminateAnimation()
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
        }
    }

    func stopLoading(showing contentView: UIView?, completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0.0
        }) { _ in
            self.shimmerLayer.removeAnimation(forKey: "shimmerSlide")
            self.progressShape.removeAnimation(forKey: "indeterminateSlide")
            self.removeFromSuperview()
            completion?()
            if let contentView = contentView {
                UIView.animate(withDuration: 0.25) {
                    contentView.alpha = 1.0
                    
                }
            }
        }
    }
}
