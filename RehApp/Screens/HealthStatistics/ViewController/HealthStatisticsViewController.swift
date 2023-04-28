//
//  HealthStatisticsViewController.swift
//  RehApp
//
//  Created by Akademija on 09.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import HealthKit

final class HealthStatisticsViewController: RehAppViewController {

    // MARK: - Properties

    private let healthStatisticsView = HealthStatisticsView()
    private var dataSource: HealthStatisticsDataSource?

    private var sections = [HealthStatisticsSection]()
    private var healthStatisticsCellRegistrations = HealthStatisticsCellRegistrations()

    var didFetchRehabilitationWorkouts = false
    var didFetchAverageHeartRates = false
    var didFetchEnergiesBurned = false

    var rehabilitations = [RehabilitationWorkout]()
    var durations = [WorkoutDurationVM]()
    var timesOfDay = [TimeOfDayVM]()
    var averageHeartRates = [HeartRateVM]()
    var energiesBurned = [EnergyBurnedVM]()

    private var collectionViewHeader: CollectionViewTitleHeader?

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
        super.viewDidAppear(animated)
        clearAllValues()
        requestHealthDataAuthorization()
    }

    private func configure() {
        healthStatisticsView.startSpinner()
        configureCollectionView()
        configureDataSourceCellRegistrations()
        configureDataSourceSupplementaryViews()
    }

    private func requestHealthDataAuthorization() {
        HealthData.shared.requestHealthAuthorization {[weak self] (success) in
            guard let self = self else { return }
            if success {
                configureUserHealthDataValues()
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
        let averageHeartRateCellRegistration = healthStatisticsCellRegistrations.averageHeartRateCellRegistration
        let activeEnergyBurnedCellRegistration = healthStatisticsCellRegistrations.activeEnergyBurnedCellRegistration
        let durationsCellRegistration = healthStatisticsCellRegistrations.durationsCellRegistration
        let timesOfDayCellRegistration = healthStatisticsCellRegistrations.timesOfDayCellRegistration
        let noItemsCellRegistration = healthStatisticsCellRegistrations.noItemsCellRegistration

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
            case .noItems:
                return collectionView.dequeueConfiguredReusableCell(using: noItemsCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            }
        })
    }

    private func configureDataSourceSupplementaryViews() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<CollectionViewTitleHeader>(elementKind: CollectionViewTitleHeader.elementKind) { [weak self] (supplementaryView, _, _) in
            guard let self = self else { return }
            supplementaryView.setHeaderTitle("Podaci rehabilitacija u proteklih 7 dana")
            collectionViewHeader = supplementaryView
        }

        guard let dataSource = dataSource else { return }
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
    }

    private func configureCollectionView() {
        let collectionView = healthStatisticsView.collectionView

        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewCompositionalLayout else {
            return
        }

        let layoutConfiguration = UICollectionViewCompositionalLayoutConfiguration()
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(1.0))
        let headerKind = CollectionViewTitleHeader.elementKind
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: headerKind,
                                                                 alignment: .topLeading)
        layoutConfiguration.boundarySupplementaryItems = [header]

        layoutConfiguration.interSectionSpacing = 16

        collectionViewLayout.configuration = layoutConfiguration
    }

    private func refreshCollectionView() {
        guard let dataSource = dataSource else { return }
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let collectionViewHeader = collectionViewHeader,
               sections.contains(.noItems) {
                collectionViewHeader.hideHeaderTitle(true)
            } else {
                collectionViewHeader?.hideHeaderTitle(false)
            }

            healthStatisticsView.startSpinner()
            dataSource.rebuildSnapshot(sections: sections, animateDifferences: true)
            healthStatisticsView.stopSpinner()
        }
    }

    // MARK: - Internal methods

    func configureChartsIfPossible() {
        if didFetchRehabilitationWorkouts,
           didFetchEnergiesBurned,
           didFetchAverageHeartRates {
            let newSections: [HealthStatisticsSection]
            if rehabilitations.isEmpty == false {
                newSections = makeSections()
            } else {
                newSections = [.noItems]
            }
            if newSections != sections {
                sections = newSections
                refreshCollectionView()
            }
        }
    }

    // MARK: - Private helper methods

    private func clearAllValues() {
        didFetchRehabilitationWorkouts = false
        didFetchAverageHeartRates = false
        didFetchEnergiesBurned = false

        rehabilitations = []
        durations = []
        timesOfDay = []
        averageHeartRates = []
        energiesBurned = []
    }

    private func makeSections() -> [HealthStatisticsSection] {
        return [
            .averageHeartRate(averageHeartRates),
            .activeEnergy(energiesBurned),
            .duration(durations),
            .timesOfDayRehabilitation(timesOfDay)
        ]
    }
}
