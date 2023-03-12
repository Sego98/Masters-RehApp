//
//  PickerView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class PickerView: UIView {

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

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 48
        return stackView
    }()

    private let subviewsVM: [PickerViewModel.PickerItemViewModel]

    // MARK: - Init

    init(subviewsVM: [PickerViewModel.PickerItemViewModel]) {
        self.subviewsVM = subviewsVM
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

        for viewModel in subviewsVM {
            let subview = PickerSubview(viewModel: viewModel)
            stackView.addArrangedSubview(subview)
        }

        let edgeOffset = CGFloat(24)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            containerView.widthAnchor.constraint(equalTo: widthAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: edgeOffset),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -edgeOffset),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }

    // MARK: - Public methods

    func setButtonActions(_ actions: [UIAction?]) {
#if DEBUG
        if actions.count != stackView.arrangedSubviews.count {
            fatalError("There should be as many action as subviews. If there is no action, put nil.")
        }
#endif
        let subviews = stackView.arrangedSubviews
        for index in 0..<subviews.count {
            guard let action = actions[index] else { return }
            guard let subview = subviews[index] as? PickerSubview else { return }
            subview.setButtonAction(action)
        }
    }
}
