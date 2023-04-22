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
//        configureUserHealthDataValues()
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
//        getAllRehabilitationWorkouts()
        HealthData.shared.fetchMostRecentQuantitySample(for: .activeEnergyBurned) { energy, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            print("Energy: \(energy ?? -1)")
        }

        HealthData.shared.fetchMostRecentQuantitySample(for: .heartRate) { heartRate, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }

            print("Heart rate: \(heartRate ?? -1)")
        }

        let now = Date()
        let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: now)!
        HealthData.shared.fetchDailyStatistics(identifier: .activeEnergyBurned,
                                               fromDate: sevenDaysAgo) { statisticsCollection, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print()
            statisticsCollection?.enumerateStatistics(from: sevenDaysAgo, to: now, with: { statistics, _ in
                print(statistics.sumQuantity() as Any)
            })
        }

        HealthData.shared.fetchDailyStatistics(identifier: .heartRate,
                                               fromDate: sevenDaysAgo) { statisticsCollection, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print()
            statisticsCollection?.enumerateStatistics(from: sevenDaysAgo, to: now, with: { statistics, _ in
                print(statistics.averageQuantity() as Any)
            })
        }
    }

}
