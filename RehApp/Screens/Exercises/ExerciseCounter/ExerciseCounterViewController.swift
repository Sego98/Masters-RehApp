//
//  ExerciseCounterViewController.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class ExerciseCounterViewController: RehAppViewController {

    // MARK: - Properties

    private let exerciseCounterView = ExerciseCounterView()
    private let exerciseVM: ExerciseDetailsVM
    private var dataSource: ExerciseCounterDataSource!
    private var counterCell: ExerciseCounterCell?

    private let exerciseCounter: Observable<Int>
    private let disposeBag = DisposeBag()

    // MARK: - Lifecycle

    init(exerciseVM: ExerciseDetailsVM) {
        self.exerciseVM = exerciseVM
        exerciseCounter = Observable<Int>
            .interval(.seconds(Int(exerciseVM.oneRepetitionTime)), scheduler: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        super.init(screenTitle: exerciseVM.title, type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = exerciseCounterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureDataSourceCellRegistrations()
        configureCounter()

        dataSource.rebuildSnapshot(viewModel: exerciseVM,
                                   animatingDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        let exerciseCounterCellRegistration = UICollectionView.CellRegistration<ExerciseCounterCell, ExerciseDetailsVM> { [weak self] (cell, _, item) in
            guard let self = self else { return }
            cell.setValues(with: item)
            counterCell = cell
            cellDidRegister()
        }

        dataSource = ExerciseCounterDataSource(collectionView: exerciseCounterView.collectionView,
                                               cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ExerciseDetailsVM) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: exerciseCounterCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func cellDidRegister() {
        configureCounter()
    }

    private func configureCounter() {
        guard let counterCell = counterCell else { return }
        let counterLabel = counterCell.makeCounterLabel()
        let numberOfRepetitions = UserDefaults.standard.integer(forKey: GlobalSettings.numberOfRepetitionsSelectedKey)

        makeProgressAnimation()

        let counter = exerciseCounter
            .take(numberOfRepetitions)
            .map { $0 + 1 }

        counter
            .map { "\($0)"}
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)

        counter
            .subscribe(onNext: {[weak self] number in
                guard let self = self else { return }
                if number < numberOfRepetitions {
                    makeProgressAnimation()
                }
            }, onCompleted: {
                print("Succeeeeeeesssssss")
            })
            .disposed(by: disposeBag)
    }

    private func makeProgressAnimation() {
        guard let counterCell = counterCell else { return }
        counterCell.makeProgressAnimation(exerciseVM.oneRepetitionTime)
    }
}
