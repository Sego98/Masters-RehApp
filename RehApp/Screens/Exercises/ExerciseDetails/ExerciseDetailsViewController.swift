//
//  ExerciseDetailsViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.03.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ExerciseDetailsViewController: RehAppViewController {

    // MARK: - Properties

    private let exerciseDetailsView: DefaultCollectionViewWithLargeButton
    private var dataSource: ExerciseDetailsDataSource!
    private let viewModel: ExerciseDetailsVM
    private let isExercisingInProgress: Bool

    // MARK: - Lifecycle

    init(viewModel: ExerciseDetailsVM, isExercisingInProgress: Bool) {
        self.viewModel = viewModel
        self.isExercisingInProgress = isExercisingInProgress
        if isExercisingInProgress {
            exerciseDetailsView = DefaultCollectionViewWithLargeButton(largeButtonTitle: "Pokreni".uppercased())
        } else {
            exerciseDetailsView = DefaultCollectionViewWithLargeButton(largeButtonTitle: "Video vježbe".uppercased())
        }
        super.init(screenTitle: viewModel.title, type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = exerciseDetailsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        if isExercisingInProgress {
            disableGoingBackwards()
        }

        configureDataSourceCellRegistrations()
        configureLargeButtonAction()

        dataSource.rebuildSnapshot(viewModel: viewModel,
                                   animatingDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        let exerciseDetailsCellRegistration = UICollectionView.CellRegistration<ExerciseDetailsCell, ExerciseDetailsVM> {cell, _, item in
            cell.setExerciseDescription(item.longDescription)
        }

        dataSource = ExerciseDetailsDataSource(collectionView: exerciseDetailsView.collectionView,
                                               cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ExerciseDetailsVM) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: exerciseDetailsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func configureLargeButtonAction() {
        if !isExercisingInProgress {
            let action = UIAction { [weak self] _ in
                guard let self = self else { return }
                presentWebModal()
            }
            setLargeButtonAction(action)
        }
    }

    private func presentWebModal() {
        let viewController = WebModalViewController(url: viewModel.videoURL,
                                                    screenTitle: viewModel.title)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }

    // MARK: - Public methods

    func setLargeButtonAction(_ action: UIAction) {
        exerciseDetailsView.setLargeButtonAction(action)
    }

    func startTimer() {
        exerciseDetailsView.activateOverlayTimer()
    }

    func timerDidFinish() {
        exerciseDetailsView.deactivateOverlayTimer()
    }

    func getOverlayTimerLabel() -> UILabel {
        return exerciseDetailsView.overlayTimerView.timerLabel
    }

}
