//
//  RemindersViewController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit

final class RemindersViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightPurple
    }
}
