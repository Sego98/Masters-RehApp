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

    private let exerciseDetailsView: DefaultView
    private var dataSource: ExerciseDetailsDataSource!
    private let viewModel: ExerciseDetailsViewModel
    private let showDetailsVideo: Bool

//    private let disposeBag = DisposeBag()

//    private let countdownTimer = Observable<Int>
//        .interval(.seconds(1), scheduler: MainScheduler.instance)
//        .take(3)
//        .observe(on: MainScheduler.instance)

    init(viewModel: ExerciseDetailsViewModel, showDetailsVideo: Bool) {
        self.viewModel = viewModel
        self.showDetailsVideo = showDetailsVideo
        if showDetailsVideo {
            exerciseDetailsView = DefaultView(largeButtonTitle: "Video vježbe".uppercased())
        } else {
            exerciseDetailsView = DefaultView(largeButtonTitle: "Nastavi".uppercased())
        }
        super.init(screenTitle: viewModel.screenTitle, type: .exercises)
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
        let exerciseDetailsCellRegistration = UICollectionView.CellRegistration<ExerciseDetailsCell, ExerciseDetailsViewModel> {cell, _, item in
            cell.setExerciseDescription(item.exerciseDescription)
        }

        dataSource = ExerciseDetailsDataSource(collectionView: exerciseDetailsView.collectionView,
                                            cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ExerciseDetailsViewModel) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: exerciseDetailsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func configureLargeButtonAction() {
        let action: UIAction
        if showDetailsVideo {
            action = UIAction { [weak self] _ in
                guard let self = self else { return }
                presentWebModal()
            }
        } else {
            action = UIAction { _ in

            }
        }
        exerciseDetailsView.setLargeButtonAction(action)
    }

    private func presentWebModal() {
        let viewController = WebModalViewController(url: viewModel.videoURL,
                                                    screenTitle: viewModel.screenTitle)
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true)
    }

    private func makeLargeButtonAction() -> UIAction {
        return UIAction { _ in
//            guard let self = self else { return }
//            self.exerciseDetailsView.activateOverlayView()
//            let overlayView = self.exerciseDetailsView.overlayView
//
//            self.countdownTimer
//                .map { "\(2 - $0)"}
//                .bind(to: overlayView.timerLabel.rx.text)
//                .disposed(by: self.disposeBag)
//
//            self.countdownTimer
//                .subscribe(onCompleted: {
//                    self.actionWhenTimerFinished()
//            }).disposed(by: self.disposeBag)
        }
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
}
