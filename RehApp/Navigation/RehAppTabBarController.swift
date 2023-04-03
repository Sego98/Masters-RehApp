//
//  RehAppTabController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit

final class RehAppTabBarController: UITabBarController {

    enum RehAppTabType {
        case picker
        case reminders

        var title: String {
            switch self {
            case .picker:
                return "Izbornik"
            case .reminders:
                return "Podsjetnici"
            }
        }

        var unselectedSystemImageName: String {
            switch self {
            case .picker:
                return "menucard"
            case .reminders:
                return "clock"
            }
        }

        var selectedSystemImageName: String {
            switch self {
            case .picker:
                return "menucard.fill"
            case .reminders:
                return "clock.fill"
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarAppearance()
        configureViewControllers()
    }

    private func configureTabBarAppearance() {
        tabBar.clipsToBounds = true
        tabBar.isTranslucent = false

        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .caption2),
            NSAttributedString.Key.kern: NSNumber(value: 1)
        ]

        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .burgundy
        UITabBar.appearance().backgroundColor = .burgundy
    }

    private func configureViewControllers() {
        let pickerVC = PickerViewController(viewModel: .pickPartToRehab)
        let pickerNC = RehAppNavigationController(rootViewController: pickerVC)
        pickerNC.tabBarItem = makeTabBarItem(.picker)

        let remindersVC = RemindersViewController()
        let remindersNC = RehAppNavigationController(rootViewController: remindersVC)
        remindersNC.tabBarItem = makeTabBarItem(.reminders)

        viewControllers = [
            pickerNC,
            remindersNC
        ]
    }

    private func makeTabBarItem(_ type: RehAppTabType) -> UITabBarItem {
        return UITabBarItem(title: type.title,
                            image: UIImage(systemName: type.unselectedSystemImageName),
                            selectedImage: UIImage(systemName: type.selectedSystemImageName))
    }
}
