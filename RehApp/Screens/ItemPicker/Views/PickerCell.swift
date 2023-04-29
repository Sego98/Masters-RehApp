//
//  PickerCell.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class PickerCell: UICollectionViewCell {

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, trait: .bold)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()

    private let pictureButton: UIButton = {
        let button = UIButton()
        let cornerRadius = CGFloat(40)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.layer.cornerRadius = cornerRadius
        button.imageView?.contentMode = .scaleAspectFill
//        button.imageView?.adjustsImageSizeForAccessibilityContentSizeCategory = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray2.cgColor
        button.layer.cornerRadius = cornerRadius
        return button
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
        backgroundColor = .rehAppBackground

        contentView.addSubviews([
            titleLabel, pictureButton
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 72, bottom: 16, trailing: 72)
        let guide = contentView.layoutMarginsGuide

        let bottomConstraint = pictureButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            pictureButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            pictureButton.heightAnchor.constraint(equalTo: pictureButton.widthAnchor),
            pictureButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            pictureButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setValues(with viewModel: PickerVM.PickerItemVM) {
        titleLabel.text = viewModel.title
        pictureButton.setImage(UIImage(named: viewModel.imageName), for: .normal)
    }

    func setButtonAction(_ action: UIAction) {
        pictureButton.addAction(action, for: .touchUpInside)
    }
}
