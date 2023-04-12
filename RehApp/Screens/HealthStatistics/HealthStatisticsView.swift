//
//  HealthStatisticsView.swift
//  RehApp
//
//  Created by Akademija on 10.04.2023..
//

import Foundation
import UIKit
import HealthKit

final class HealthStatisticsView: UIView {

    // MARK: - Properties

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()

    private let heightView = KeyValueView()
    private let massView = KeyValueView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
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
        backgroundColor = .rehAppBackground

        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubviews([
            nameLabel, heightView, massView
        ])

        containerView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = containerView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setName(_ name: String?) {
        nameLabel.text = name
    }

    func setHeight(_ heightInMeters: Measurement<UnitLength>?) {
        heightView.setKey(key: "Visina")
        guard let heightInMeters = heightInMeters else {
            heightView.setValue(nil)
            return
        }
        heightView.setValue(Formatters.heightFormatter.string(fromMeters: heightInMeters.value))
    }

    func setMass(_ massInGrams: Measurement<UnitMass>?) {
        massView.setKey(key: "Masa")
        guard let massInGrams = massInGrams else {
            massView.setValue(nil)
            return
        }
        let massInKilograms = massInGrams.converted(to: .kilograms)
        massView.setValue(Formatters.massFormatter.string(fromKilograms: massInKilograms.value))
    }

}
