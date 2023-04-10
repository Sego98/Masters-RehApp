//
//  RehAppViewController.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
//

import Foundation
import UIKit
import CoreData

class RehAppViewController: UIViewController {

    // MARK: - Properties

    private let screenTitle: String?
    private let type: RehAppTabType?

    // MARK: - Lifecycle

    init(screenTitle: String? = nil, type: RehAppTabType? = nil) {
        self.screenTitle = screenTitle
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
    }

    private func configureNavigationBar() {
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.backgroundColor = .burgundy
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.white]

        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.prefersLargeTitles = true

        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = screenTitle

        if let type = type {
            navigationItem.rightBarButtonItem = makeBarButtonItem(type)
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }

    private func makeBarButtonItem(_ type: RehAppTabType) -> UIBarButtonItem? {
        var barButtonItem: UIBarButtonItem?
        let exercisingBarButton = UIBarButtonItem(image: UIImage(systemName: "figure.strengthtraining.functional"),
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(rightExercisingBarButtonTapped))
        switch type {
        case .exercises:
            barButtonItem = exercisingBarButton
        case .reminders:
            barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self,
                                            action: nil)
        case .statistics:
            barButtonItem = exercisingBarButton
        }
        barButtonItem?.tintColor = .white
        return barButtonItem
    }

    @objc func rightExercisingBarButtonTapped(_ sender: UIBarButtonItem) {
        let calendarViewController = StreakCalendarViewController()

        present(calendarViewController, animated: true)
    }
}
