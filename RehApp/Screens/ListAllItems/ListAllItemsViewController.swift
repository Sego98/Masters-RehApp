//
//  ListAllItemsViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit

final class ListAllItemsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ListAllItemsViewModel
    private let listAllItemsView: ListAllItemsView
    private var dataSource: ListAllItemsDataSource!

    // MARK: - Lifecycle

    init(viewModel: ListAllItemsViewModel) {
        self.viewModel = viewModel
        self.listAllItemsView = ListAllItemsView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
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
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = viewModel.screenTitle
        navigationItem.largeTitleDisplayMode = .automatic

        let allItemsCellRegistration = UICollectionView.CellRegistration<ListAllItemsCell, ListAllItemsViewModel.ItemViewModel> {cell, indexPath, item in
            let number = indexPath.item + 1
            cell.setParameters(number: number, description: item.shortDescription)
        }

        listAllItemsView.setCollectionViewDelegate(self)
        let collectionView = listAllItemsView.getCollectionView()

        dataSource = ListAllItemsDataSource(collectionView: collectionView,
                                            cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, item: ListAllItemsViewModel.ItemViewModel) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: allItemsCellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })

        let headerRegistration = UICollectionView.SupplementaryRegistration<ListAllItemsHeader>(elementKind: ListAllItemsHeader.elementKind) { [weak self] (supplementaryView, _, _) in
            guard let self = self else { return }
            supplementaryView.setValues(with: self.viewModel)
        }

        dataSource.supplementaryViewProvider = { (collectionView, elementKind, indexPath) -> UICollectionReusableView? in
            if elementKind == ListAllItemsHeader.elementKind {
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                             for: indexPath)
            }
            return nil
        }

        dataSource.rebuildSnapshot(items: viewModel.items, animatingDifferences: true)
    }
}
