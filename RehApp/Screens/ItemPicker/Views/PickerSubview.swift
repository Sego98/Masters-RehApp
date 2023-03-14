//
//  PickerSubview.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class PickerSubview: UIView {

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title1)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let pictureButton: UIButton = {
        let button = UIButton()
        let cornerRadius = CGFloat(40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.layer.cornerRadius = cornerRadius
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.cornerRadius = cornerRadius
        return button
    }()

    private let viewModel: PickerViewModel.PickerItemViewModel

    // MARK: - Init

    init(viewModel: PickerViewModel.PickerItemViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .rehAppBackground

        titleLabel.text = viewModel.title
        pictureButton.setImage(UIImage(named: viewModel.imageName), for: .normal)

        addSubviews([
            titleLabel, pictureButton
        ])

        directionalLayoutMargins = .zero
        let guide = layoutMarginsGuide

        let imageDimension = CGFloat(200)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            pictureButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            pictureButton.heightAnchor.constraint(equalToConstant: imageDimension),
            pictureButton.widthAnchor.constraint(equalToConstant: imageDimension),
            pictureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            pictureButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setButtonAction(_ action: UIAction) {
        pictureButton.addAction(action, for: .touchUpInside)
    }
}
