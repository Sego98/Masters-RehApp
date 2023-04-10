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
        HealthData.requestHealthAuthorization()

        let heightType = HKQuantityType(HKQuantityTypeIdentifier.height)
        HealthData.getMostRecentQuantitySample(for: heightType) { [self] sample, error in
            guard let sample = sample else {
                if let error = error {
                    print("No height, \(error.localizedDescription)")
                }
                return
            }
            let heightInMeters = sample.quantity.doubleValue(for: .meter())
            self.healthStatisticsView.setValues(name: "Petar Ljubotina", height: heightInMeters)
        }

    }

}
