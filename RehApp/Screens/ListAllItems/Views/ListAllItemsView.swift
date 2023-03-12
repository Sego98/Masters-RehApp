//
//  ListAllItemsView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation
import UIKit

final class ListAllItemsView: UIView {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        return tableView
    }()

    private let allItemsButton: LargeButton

    init(viewModel: ListAllItemsViewModel) {
        self.allItemsButton = LargeButton(title: viewModel.largeButtonTitle.uppercased())
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .systemBackground

        addSubview(tableView)
        addSubview(allItemsButton)

        let edgeOffset = CGFloat(24)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeOffset),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeOffset),

            allItemsButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            allItemsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edgeOffset),
            allItemsButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edgeOffset),
            allItemsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
