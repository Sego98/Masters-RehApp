//
//  HealthStatisticsView.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import UIKit

final class HealthStatisticsView: UIView {

    // MARK: - Properties

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground
    }
}
