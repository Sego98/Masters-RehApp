//
//  NumberOfRepetitionsViewController.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class NumberOfRepetitionsViewController: RehAppViewController {

    // MARK: - Properties

    private let numberOfRepetitionsView = NumberOfRepetitionsView()

    // MARK: - Lifecycle

    init() {
        super.init(screenTitle: "Broj ponavljanja", type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = numberOfRepetitionsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {

    }
}
