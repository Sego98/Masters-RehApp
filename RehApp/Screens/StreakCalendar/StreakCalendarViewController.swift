//
//  StreakCalendarViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 30.03.2023..
//

import Foundation
import UIKit

final class StreakCalendarViewController: UIViewController {

    // MARK: - Properties

    private let streakCalendarView = StreakCalendarView()

    // MARK: - Init

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = streakCalendarView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(preferredContentSizeCategoryDidChange),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
        guard let presentationController = presentationController as? UISheetPresentationController else { return }
        presentationController.prefersGrabberVisible = true
        setPresentationControllerDetents()
    }

    private func setPresentationControllerDetents() {
        guard let presentationController = presentationController as? UISheetPresentationController else { return }

        let preferredContentSizeCategory = UIApplication.shared.preferredContentSizeCategory
        let isAccessibility = preferredContentSizeCategory >= .accessibilityMedium

        presentationController.detents = isAccessibility ? [.large()] : [.medium(), .large()]
    }

    // MARK: - Public methods

    @objc func preferredContentSizeCategoryDidChange(_ notification: Notification) {
        setPresentationControllerDetents()
    }
}
