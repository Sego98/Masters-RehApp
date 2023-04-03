//
//  RehAppViewController.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
//

import Foundation
import UIKit

class RehAppViewController: UIViewController {

    private let screenTitle: String?

    init(screenTitle: String? = nil) {
        self.screenTitle = screenTitle
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

        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "figure.strengthtraining.functional"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white

    }

    @objc func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        let calendarViewController = StreakCalendarViewController()

        present(calendarViewController, animated: true)
    }
}