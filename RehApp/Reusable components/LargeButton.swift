//
//  LargeButton.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

class LargeButton: UIButton {

    private let title: String

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

        layer.cornerRadius = 40
        backgroundColor = .systemGray2

        titleLabel?.font = .preferredFont(forTextStyle: .title2)

        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 80)
        ])
    }
}
