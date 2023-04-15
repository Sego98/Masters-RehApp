//
//  ListAllExercisesViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit

final class ListAllExercisesViewController: RehAppViewController {

    // MARK: - Properties

    let viewModel: ListAllExercisesVM
    private let listAllItemsView: ListAllExercisesView
    private var dataSource: ListAllExercisesDataSource!

    // MARK: - Lifecycle

    init(viewModel: ListAllExercisesVM) {
        self.viewModel = viewModel
        self.listAllItemsView = ListAllExercisesView(viewModel: viewModel)
        super.init(screenTitle: viewModel.screenTitle, type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = listAllItemsView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        configureDataSourceCellRegistrations()
        configureDataSourceSupplementaryViews()
        configureProperties()

        dataSource.rebuildSnapshot(items: viewModel.items, animatingDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        let allItemsCellRegistration = UICollectionView.CellRegistration<ListAllExercisesCell, ExerciseListItemVM> {cell, indexPath, item in
            let number = indexPath.item + 1
            cell.setParameters(number: number, description: item.shortDescription)
        }

        dataSource = ListAllExercisesDataSource(collectionView: listAllItemsView.collectionView,
                                            cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ExerciseListItemVM) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: allItemsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })
    }

    private func configureDataSourceSupplementaryViews() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<ListAllExercisesHeader>(elementKind: ListAllExercisesHeader.elementKind) { [weak self] (supplementaryView, _, _) in
            guard let self = self else { return }
            supplementaryView.setValues(with: self.viewModel)
        }

        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == ListAllExercisesHeader.elementKind {
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                             for: indexPath)
            }
            return nil
        }
    }

    private func configureProperties() {
        listAllItemsView.collectionView.delegate = self

        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            let viewController = NumberOfRepetitionsViewController()
            viewController.exerciseDetailsDelegate = self
            navigationController?.pushViewController(viewController, animated: true)
        }

        listAllItemsView.setLargeButtonAction(action)
    }
}

extension ListAllExercisesViewController: ExerciseDetailsDelegate {

    func makeExerciseDetailsViewModels() -> [ExerciseDetailsViewModel] {
        let exerciseDetailsViewModels = viewModel.items.map({ ExerciseDetailsViewModel(screenTitle: $0.title,
                                                                                       exerciseDescription: $0.longDescription,
                                                                                       videoURL: nil)})
        return exerciseDetailsViewModels
    }

}
