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

    private let exerciseDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        return label
    }()

    private let exerciseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .lightPurple
        return imageView
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

    private let screenDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        label.text = """
        Na slici iznad možete vidjeti kako izgleda vježba dok se izvodi u pravilnom položaju. Za pravilno izvođenje \
        cijelog pokreta vježbe pogledajte video koji se otvara pritiskom na gumb pri dnu ekrana.
        """
        return label
    }()

//    let overlayView = OverlayView()

    private let largeButton = LargeButton(title: "Video vježbe".uppercased())

    private let exerciseDescription: String

    init(exerciseDescription: String) {
        self.exerciseDescription = exerciseDescription
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        exerciseDescriptionLabel.text = exerciseDescription
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        addSubview(largeButton)

        containerView.addSubviews([
            exerciseDescriptionLabel,
            exerciseImageView,
            screenDescriptionLabel
        ])

        containerView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 24, bottom: 0, trailing: 24)
        let guide = containerView.layoutMarginsGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            exerciseDescriptionLabel.topAnchor.constraint(equalTo: guide.topAnchor),
            exerciseDescriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            exerciseDescriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),

//            chooseNumberOfRepetitionsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//            chooseNumberOfRepetitionsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
//                                                                    constant: edgeOffset),
//            chooseNumberOfRepetitionsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
//                                                                     constant: -edgeOffset),

//            pickerView.topAnchor.constraint(equalTo: chooseNumberOfRepetitionsLabel.bottomAnchor, constant: 8),
//            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: edgeOffset),
//            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -edgeOffset),

//            nextScreenDescriptionLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 8),

            exerciseImageView.topAnchor.constraint(equalTo: exerciseDescriptionLabel.bottomAnchor, constant: 24),
            exerciseImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 80),
            exerciseImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -80),
            exerciseImageView.heightAnchor.constraint(equalTo: exerciseImageView.widthAnchor),

            screenDescriptionLabel.topAnchor.constraint(equalTo: exerciseImageView.bottomAnchor, constant: 24),
            screenDescriptionLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            screenDescriptionLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            screenDescriptionLabel.bottomAnchor.constraint(equalTo: guide.bottomAnchor),

            largeButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 16),
            largeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            largeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            largeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
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
