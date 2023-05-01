//
//  CollectionViewTitleHeader.swift
//  RehApp
//
//  Created by Petar Ljubotina on 25.04.2023..
//

import Foundation
import UIKit

final class CollectionViewTitleHeader: UICollectionReusableView {

    static var elementKind: String { String(describing: self) }

    // MARK: - Properties

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, trait: .bold)
        label.numberOfLines = 0
        return label
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(stackView)
        stackView.addArrangedSubview(headerLabel)

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let guide = layoutMarginsGuide

        let bottomConstraint = stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setHeaderTitle(_ title: String) {
        headerLabel.text = title
    }

    func hideHeaderTitle(_ isHidden: Bool) {
        headerLabel.isHidden = isHidden
    }
}
