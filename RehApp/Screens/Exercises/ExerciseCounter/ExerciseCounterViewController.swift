//
//  ExerciseCounterViewController.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class ExerciseCounterViewController: RehAppViewController {

    // MARK: - Lifecycle

    init(screenTitle: String) {
        super.init(screenTitle: screenTitle, type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
