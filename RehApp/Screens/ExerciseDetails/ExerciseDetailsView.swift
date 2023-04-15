//
//  ExerciseDetailsView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.03.2023..
//

import Foundation
import UIKit

class ExerciseDetailsView: UIView {

    // MARK: - Properties

    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: .defaultLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .rehAppBackground
        return collectionView
    }()

//    private let chooseNumberOfRepetitionsLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.adjustsFontForContentSizeCategory = true
//        label.textColor = .label
//        label.textAlignment = .left
//        label.text = "Odaberi broj ponavljanja:"
//        label.font = .preferredFont(forTextStyle: .title1)
//        label.numberOfLines = 0
//        return label
//    }()

//    let pickerView: UIPickerView = {
//        let pickerView = UIPickerView()
//        pickerView.translatesAutoresizingMaskIntoConstraints = false
//        return pickerView
//    }()

//    let overlayView = OverlayView()

    private let largeButton = LargeButton(title: "Video vježbe".uppercased())

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

        addSubviews([
            collectionView, largeButton
        ])

        directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24)
        let guide = layoutMarginsGuide

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: guide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),

            largeButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            largeButton.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            largeButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            largeButton.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])

//
//        NSLayoutConstraint.activate([

//            chooseNumberOfRepetitionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//            chooseNumberOfRepetitionsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
//                                                                    constant: edgeOffset),
//            chooseNumberOfRepetitionsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
//                                                                     constant: -edgeOffset),

//            pickerView.topAnchor.constraint(equalTo: chooseNumberOfRepetitionsLabel.bottomAnchor, constant: 8),
//            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: edgeOffset),
//            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -edgeOffset),

//            nextScreenDescriptionLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 8),

//
//            screenDescriptionLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 24),
//            screenDescriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
//            screenDescriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
//            screenDescriptionLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

    }

//    func selectMiddleRow(from items: [Int]) {
//        let selectedIndex = Int(items.count / 2)
//        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
//    }

    func setLargeButtonAction(_ action: UIAction) {
        largeButton.addAction(action, for: .touchUpInside)
    }

//    func activateOverlayView() {
//        overlayView.timerLabel.text = "3"
//        addSubview(overlayView)
//        largeButton.isEnabled = false
//
//        NSLayoutConstraint.activate([
//            overlayView.topAnchor.constraint(equalTo: topAnchor),
//            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    func deactivateOverlayView() {
//        overlayView.removeFromSuperview()
//        largeButton.isEnabled = true
//    }
}
