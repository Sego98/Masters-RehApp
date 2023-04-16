//
//  ExerciseCounterViewController.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit

final class ExerciseCounterViewController: RehAppViewController {

    // MARK: - Properties

    private let exerciseCounterView = ExerciseCounterView()
    private var dataSource: ExerciseCounterDataSource!
    private let exerciseVM: ExerciseDetailsVM

    // MARK: - Lifecycle

    init(exerciseVM: ExerciseDetailsVM) {
        self.exerciseVM = exerciseVM
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
        
        dataSource.rebuildSnapshot(viewModel: exerciseVM,
                                   animatingDifferences: true)
    }
    
    private func configureDataSourceCellRegistrations() {
        let exerciseCounterCellRegistration = UICollectionView.CellRegistration<ExerciseCounterCell, ExerciseDetailsVM> {cell, _, item in
            cell.setValues(with: item)
        }
        
        dataSource = ExerciseCounterDataSource(collectionView: exerciseCounterView.collectionView,
                                               cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ExerciseDetailsVM) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: exerciseCounterCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }
}
