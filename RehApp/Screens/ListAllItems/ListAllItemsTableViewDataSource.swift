//
//  ListAllItemsTableViewDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllItemsTableViewDataSource: NSObject, UITableViewDataSource {

    private let viewModel: ListAllItemsViewModel

    init(viewModel: ListAllItemsViewModel) {
        self.viewModel = viewModel
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListAllItemsCell.identifier,
                                                       for: indexPath) as? ListAllItemsCell else {
            let unexpectedCell = UITableViewCell()
            unexpectedCell.backgroundColor = .red
            return unexpectedCell
        }
        let itemVM = viewModel.items[indexPath.row]
        cell.setParameters(number: indexPath.row + 1, description: itemVM.shortDescription)
        return cell
    }
}
