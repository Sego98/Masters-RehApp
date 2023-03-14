//
//  ListAllItemsViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllItemsViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: ListAllItemsViewModel
    private let listAllItemsView: ListAllItemsView
    private let dataSource: ListAllItemsTableViewDataSource

    // MARK: - Lifecycle

    init(viewModel: ListAllItemsViewModel) {
        self.viewModel = viewModel
        self.listAllItemsView = ListAllItemsView(viewModel: viewModel)
        self.dataSource = ListAllItemsTableViewDataSource(viewModel: viewModel)
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

        let tableView = listAllItemsView.tableView
        tableView.register(ListAllItemsHeader.self, forHeaderFooterViewReuseIdentifier: ListAllItemsHeader.identifier)
        tableView.register(ListAllItemsCell.self, forCellReuseIdentifier: ListAllItemsCell.identifier)
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

    // MARK: - UITableView delegate

extension ListAllItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = ListAllItemsHeader.identifier
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        as? ListAllItemsHeader else { return nil }
        headerView.setParameters(itemVM: viewModel)
        return headerView
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let exerciseDescription = viewModel.items[indexPath.row].longDescription
//        let screenTitle = "Vježba broj \(indexPath.row + 1)"
//        let viewModel = ExerciseDetailsViewModel(screenTitle: screenTitle,
//                                                 exerciseDescription: exerciseDescription)
//        let viewController = ExerciseDetailsViewController(viewModel: viewModel)
//        navigationController?.pushViewController(viewController, animated: true)
    }
}
