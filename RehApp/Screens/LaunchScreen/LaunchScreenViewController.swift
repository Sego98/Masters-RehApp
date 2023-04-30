//
//  LaunchScreenViewController.swift
//  RehApp
//
//  Created by Akademija on 27.04.2023..
//

import Foundation
import UIKit

final class LaunchScreenViewController: UIViewController {

    // MARK: - Properties

    private let launchScreenView = LaunchScreenView()

    // MARK: - Lifecycle

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func loadView() {
        view = launchScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        launchScreenView.setImageViewCenterPoint(to: launchScreenView.center)
        animate()
    }

    private func configure() {
        launchScreenView.backgroundColor = .burgundy
    }

    private func animate() {
        UIView.animate(withDuration: 1.2) { [weak self] in
            guard let self = self else { return }
            let size = view.frame.size.width * 4

            let diffX = size - view.frame.size.width
            let diffY = view.frame.size.height - size

            launchScreenView.setImageViewFrame(CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            ))

            launchScreenView.setImageViewAlpha(0)

        } completion: { [weak self] done in
            if done {
                guard let self = self else { return }
                let tabBarController = RehAppTabBarController()
                tabBarController.modalTransitionStyle = .flipHorizontal
                tabBarController.modalPresentationStyle = .fullScreen
                present(tabBarController, animated: true)
            }
        }
    }
}
