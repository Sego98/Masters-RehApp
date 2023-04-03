//
//  RemindersViewController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit

final class RemindersViewController: RehAppViewController {

    // MARK: - Properties

    private let remindersView = RemindersView()

    // MARK: - Lifecycle

    init() {
        super.init(screenTitle: "Podsjetnici", type: .reminders)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = remindersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {

    }
}
