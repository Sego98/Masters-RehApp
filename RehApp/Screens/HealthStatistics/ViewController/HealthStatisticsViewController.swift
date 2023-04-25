//
//  HealthStatisticsViewController.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import SwiftUI
import HealthKit

final class HealthStatisticsViewController: RehAppViewController {

    // MARK: - Properties

    private let healthStatisticsView = HealthStatisticsView()
    private var dataSource: HealthStatisticsDataSource?

    private var sections = [HealthStatisticsSection]()

    var rehabilitations = [RehabilitationWorkout]()
    var durations = [WorkoutDurationVM]()
    var timesOfDay = [TimeOfDayVM]()
    var averageHeartRates = [HeartRateVM]()
    var energiesBurned = [EnergyBurnedVM]()

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

    override func viewDidAppear(_ animated: Bool) {
        requestHealthDataAuthorization()
    }

    private func configure() {
        configureDataSourceCellRegistrations()
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
        let now = Date()
        let startDate = Calendar.current.date(byAdding: DateComponents(day: -6), to: now)!
        fetchAllRehabilitationWorkouts(from: startDate)
        fetchAverageQuantitiesForRehabilitations(identifier: .heartRate, from: startDate)
        fetchAverageQuantitiesForRehabilitations(identifier: .activeEnergyBurned, from: startDate)
    }

    private func configureDataSourceCellRegistrations() {
        let averageHeartRateCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
            guard let heartRates = item.averageHeartRates else { return }
            cell.contentConfiguration = UIHostingConfiguration(content: {
                AverageHeartRateCellView(heartRates: heartRates)
            })
        }

        let activeEnergyBurnedCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
            guard let energiesBurned = item.activeEnergiesBurned else { return }
            cell.contentConfiguration = UIHostingConfiguration(content: {
                EnergyBurnedCellView(energiesBurned: energiesBurned)
            })
        }

        let durationsCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
            guard let durations = item.durations else { return }
            cell.contentConfiguration = UIHostingConfiguration(content: {
                DurationCellView(durations: durations)
            })
        }

        let timesOfDayCellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, HealthStatisticsSection> { cell, _, item in
            guard let timesOfDay = item.timesOfDay else { return }
            cell.contentConfiguration = UIHostingConfiguration(content: {
                TimeOfDayCellView(timesOfDay: timesOfDay)
            })
        }

        dataSource = HealthStatisticsDataSource(collectionView: healthStatisticsView.collectionView, cellProvider: { collectionView, indexPath, item in
            let section = self.sections[indexPath.section]
            switch section {
            case .averageHeartRate:
                return collectionView.dequeueConfiguredReusableCell(using: averageHeartRateCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .activeEnergy:
                return collectionView.dequeueConfiguredReusableCell(using: activeEnergyBurnedCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .duration:
                return collectionView.dequeueConfiguredReusableCell(using: durationsCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .timesOfDayRehabilitation:
                return collectionView.dequeueConfiguredReusableCell(using: timesOfDayCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            }
        })
    }

    func configureChartsIfPossible() {
        print(durations.count)
        print(rehabilitations.count)
        print(averageHeartRates.count)
        print(energiesBurned.count)
        if durations.isEmpty == false,
           timesOfDay.isEmpty == false,
           averageHeartRates.count == rehabilitations.count,
           energiesBurned.count == durations.count {
            makeSections()
            guard let dataSource = dataSource else { return }
            dataSource.rebuildSnapshot(sections: sections, animateDifferences: true)
        }
    }

    private func makeSections() {
        sections = [
            .averageHeartRate(averageHeartRates),
            .activeEnergy(energiesBurned),
            .duration(durations),
            .timesOfDayRehabilitation(timesOfDay)
        ]
    }
}
