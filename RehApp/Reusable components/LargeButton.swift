//
//  LargeButton.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

class LargeButton: UIButton {

    // MARK: - Properties

    private let title: String

    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            backgroundColor = newValue ? .lightPurple.withAlphaComponent(0.6) : .lightPurple
        }
    }

    // MARK: - Init

    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        setTitle(title, for: .normal)

        layer.cornerRadius = 30
        backgroundColor = .lightPurple

        titleLabel?.font = .preferredFont(for: .title2, trait: .bold)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.numberOfLines = 0

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
}
