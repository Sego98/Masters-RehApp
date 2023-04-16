//
//  OverlayView.swift
//  RehApp
//
//  Created by Akademija on 16.03.2023..
//

import Foundation
import UIKit

final class OverlayTimerView: UIView {

    // MARK: - Properties

    let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 60)
        return label
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
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.85)

        translatesAutoresizingMaskIntoConstraints = false

        addSubview(timerLabel)

        NSLayoutConstraint.activate([
            timerLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
