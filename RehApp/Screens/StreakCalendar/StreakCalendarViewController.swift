//
//  StreakCalendarViewController.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
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
        if let presentationController = presentationController as? UISheetPresentationController {
            presentationController.detents = [.medium()]
            presentationController.prefersGrabberVisible = true
        }
    }
}
