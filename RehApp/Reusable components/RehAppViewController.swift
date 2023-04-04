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
    private let type: RehAppTabType

    let mainViewContext: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "RehAppCoreData")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        })
        return container.viewContext
    }()

    // MARK: - Lifecycle

    init(screenTitle: String? = nil, type: RehAppTabType = .exercises) {
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

        navigationItem.rightBarButtonItem = makeBarButtonItem(type)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }

    private func makeBarButtonItem(_ type: RehAppTabType) -> UIBarButtonItem? {
        var barButtonItem: UIBarButtonItem?
        switch type {
        case .exercises:
            barButtonItem = UIBarButtonItem(image: UIImage(systemName: "figure.strengthtraining.functional"),
                                   style: .plain,
                                   target: self,
                                   action: #selector(rightBarButtonTapped))
        case .reminders:
            barButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                   style: .plain,
                                   target: self,
                                   action: nil)
        }
        barButtonItem?.tintColor = .white
        return barButtonItem
    }

    @objc func rightBarButtonTapped(_ sender: UIBarButtonItem) {
        let calendarViewController = StreakCalendarViewController()

        present(calendarViewController, animated: true)
    }
}
