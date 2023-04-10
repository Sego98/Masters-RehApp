//
//  HealthStatisticsViewController.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//

import Foundation
import UIKit
import HealthKit

final class HealthStatisticsViewController: RehAppViewController {

    // MARK: - Properties

    private let healthStatisticsView = HealthStatisticsView()
    private let healthStore = HealthData.healthStore

    // MARK: - Lifecycle

    init() {
        super.init(screenTitle: "Statistika", type: .statistics)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = healthStatisticsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .rehAppBackground
        configure()
    }

    private func configure() {
        requestHealthAuthorization()
    }

    private func requestHealthAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            healthDataNotAvailable()
            return
        }

        healthStore.requestAuthorization(toShare: Set(HealthData.shareDataTypes),
                                         read: Set(HealthData.readDataTypes)) { success, error in
            if success {
#if DEBUG
                print("HealthKit authorization has been successful!")
#endif
            } else {
#if DEBUG
                print("HealthKit authorization was not successful. :(")
#endif
            }

            if let error = error {
#if DEBUG
                print(error.localizedDescription)
#endif
            }
        }
    }

    private func healthDataNotAvailable() {
        let title = "Health Data Unavailable"
        let message = "It looks like this device cannot enter health data. Make sure to use the proper device."
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default)

        alertController.addAction(action)

        present(alertController, animated: true)
    }

}
