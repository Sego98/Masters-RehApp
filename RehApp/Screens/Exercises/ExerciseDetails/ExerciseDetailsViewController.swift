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
    private let showDetailsVideo: Bool

    // MARK: - Lifecycle

    init(viewModel: ExerciseDetailsVM, showDetailsVideo: Bool) {
        self.viewModel = viewModel
        self.showDetailsVideo = showDetailsVideo
        if showDetailsVideo {
            exerciseDetailsView = DefaultCollectionViewWithLargeButton(largeButtonTitle: "Video vježbe".uppercased())
        } else {
            exerciseDetailsView = DefaultCollectionViewWithLargeButton(largeButtonTitle: "Nastavi".uppercased())
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
        if showDetailsVideo {
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

    private func actionWhenTimerFinished() {
//        let selectedIndex = exerciseDetailsView.pickerView.selectedRow(inComponent: 0)
//        let viewModel = ExerciseCounterViewModel(screenTitle: viewModel.screenTitle,
//                                                 exerciseDescription: viewModel.exerciseDescription,
//                                                 numberOfRepetitions: numberOfRepetitions[selectedIndex])
//        let viewController = ExerciseCounterViewController(viewModel: viewModel)
//        navigationController?.pushViewController(viewController, animated: true)
//        exerciseDetailsView.deactivateOverlayView()
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
