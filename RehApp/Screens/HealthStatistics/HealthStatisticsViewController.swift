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

    let healthStatisticsView = HealthStatisticsView()

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
        requestHealthDataAuthorization()
        configureUserHealthDataValues()
    }

    private func requestHealthDataAuthorization() {
        HealthData.shared.requestHealthAuthorization {[weak self] (success) in
            guard let self = self else { return }
            if success {
                DispatchQueue.main.async {
                    self.configureUserHealthDataValues()
                }
            }
        }
    }
    private func configureUserHealthDataValues() {
        setUserName()
        setUserHeightFromHealthData()
        setUserMassFromHealthData()

        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -6, to: now)!
        let endDate = now
        HealthData.shared.fetchDailyStatistics(identifier: .activeEnergyBurned,
                                               fromDate: startDate) {  statistics in
            DispatchQueue.main.async {
                statistics?.enumerateStatistics(from: startDate, to: endDate, with: { statistics, _ in
                    let quantity = statistics.sumQuantity()
                    let value = quantity?.doubleValue(for: .count())
                    print(quantity)
                })
            }
        }
    }
}
