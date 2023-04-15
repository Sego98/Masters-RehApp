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

    private let exerciseDetailsView = ExerciseDetailsView()
    private var dataSource: ExerciseDetailsDataSource!
    private let viewModel: ExerciseDetailsViewModel

//    private let numberOfRepetitions = [4, 5, 6, 7, 8, 9, 10, 11, 12]

//    private let disposeBag = DisposeBag()

//    private let countdownTimer = Observable<Int>
//        .interval(.seconds(1), scheduler: MainScheduler.instance)
//        .take(3)
//        .observe(on: MainScheduler.instance)

    init(viewModel: ExerciseDetailsViewModel) {
//        self.pickerDataSource = ExerciseDetailsPickerDataSource(numberOfRepetitions: numberOfRepetitions)
        self.viewModel = viewModel
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
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.title = viewModel.screenTitle
//        navigationItem.largeTitleDisplayMode = .automatic

//        let pickerView = exerciseDetailsView.pickerView
//        pickerView.delegate = self
//        pickerView.dataSource = pickerDataSource
//
//        exerciseDetailsView.selectMiddleRow(from: numberOfRepetitions)
        configureDataSourceCellRegistrations()
        configureProperties()

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

    private func configureProperties() {
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            let viewController = WebModalViewController(url: viewModel.videoURL,
                                                        screenTitle: viewModel.screenTitle)
            let navigationController = UINavigationController(rootViewController: viewController)
            present(navigationController, animated: true)
        }
        exerciseDetailsView.setLargeButtonAction(action)
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

// extension ExerciseDetailsViewController: UIPickerViewDelegate {
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return String(numberOfRepetitions[row])
//    }
// }
