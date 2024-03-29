//
//  NumberOfRepetitionsCell.swift
//  RehApp
//
//  Created by Petar Ljubotina on 15.04.2023..
//

import Foundation
import UIKit

final class NumberOfRepetitionsCell: UICollectionViewCell {

    // MARK: - Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(for: .title1, trait: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "ChooseNumberOfRepetitions".localize()
        return label
    }()

    private let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "NumberOfRepetitionsDescription".localize()
        return label
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
        contentView.addSubviews([
            titleLabel, pickerView,
            descriptionLabel
        ])

        contentView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        let guide = contentView.layoutMarginsGuide

        let bottomConstraint = descriptionLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        bottomConstraint.priority = .defaultHigh

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            pickerView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            pickerView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

            descriptionLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            bottomConstraint
        ])
    }

    // MARK: - Public methods

    func setPickerViewDataSource(_ dataSource: UIPickerViewDataSource) {
        pickerView.dataSource = dataSource
    }

    func setPickerViewDelegate(_ delegate: UIPickerViewDelegate) {
        pickerView.delegate = delegate
    }

    func selectPickerMiddleItem(completion: (Int) -> Void) {
        guard pickerView.numberOfRows(inComponent: 0) > 0 else { return }
        let numberOfItems = Double(pickerView.numberOfRows(inComponent: 0))
        let selectedIndex = Int((numberOfItems / 2.0).rounded() - 1)
        pickerView.selectRow(selectedIndex,
                             inComponent: 0,
                             animated: true)
        completion(selectedIndex)
    }
}
