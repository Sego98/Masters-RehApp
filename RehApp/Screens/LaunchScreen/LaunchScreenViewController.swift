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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animate()
        }
    }

    private func configure() {
        launchScreenView.backgroundColor = .systemMint
    }

    private func animate() {
        UIView.animate(withDuration: 1) { [weak self] in
            guard let self = self else { return }
            let frame = view.frame
            let size = frame.size.width * 3

            let diffX = size - frame.size.width
            let diffY = frame.size.height - size

            launchScreenView.setImageViewFrame(CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            ))
        }

        UIView.animate(withDuration: 1.75) { [weak self] in
            guard let self = self else { return }
            launchScreenView.setImageViewAlpha(0)
        } completion: {  done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) { [weak self] in
                    guard let self = self else { return }
                    let tabBarController = RehAppTabBarController()
                    tabBarController.modalTransitionStyle = .flipHorizontal
                    tabBarController.modalPresentationStyle = .fullScreen
                    self.present(tabBarController, animated: true)
                }
            }
        }
    }
}
