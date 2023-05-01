//
//  LaunchScreenView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 27.04.2023..
//

import Foundation
import UIKit

final class LaunchScreenView: UIView {

    // MARK: - Properties

    private let imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(
            x: 0,
            y: 0,
            width: 300,
            height: 300
        ))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "RehAppIcon")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(imageView)
    }

    // MARK: - Public methods

    func setImageViewFrame(_ frame: CGRect) {
        imageView.frame = frame
    }

    func setImageViewCenterPoint(to centerPoint: CGPoint) {
        imageView.center = centerPoint
    }

    func setImageViewAlpha(_ alpha: CGFloat) {
        imageView.alpha = alpha
    }
}
