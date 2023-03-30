//
//  RehAppViewController.swift
//  RehApp
//
//  Created by Akademija on 30.03.2023..
//

import Foundation
import UIKit

class RehAppViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureNavigationBar(title: String? = nil) {
        let navBarAppearence = UINavigationBarAppearance()
        navBarAppearence.backgroundColor = .burgundy
        navBarAppearence.largeTitleTextAttributes = [.foregroundColor: UIColor.beige]
        navBarAppearence.titleTextAttributes = [.foregroundColor: UIColor.beige]

        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearence
        navigationController?.navigationBar.standardAppearance = navBarAppearence
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .burgundy

        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = title

        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "figure.strengthtraining.functional"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(rightBarButtonTapped))
        rightBarButton.tintColor = .beige
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .beige

    }

    @objc func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        let calendarViewController = StreakCalendarViewController()

        present(calendarViewController, animated: true)
    }
}
