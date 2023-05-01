//
//  RemindersView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 03.04.2023..
//

import Foundation
import UIKit

final class RemindersView: UIView {

    // MARK: - Properties

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isUserInteractionEnabled = true
        tableView.separatorStyle = .none
        tableView.backgroundColor = .rehAppBackground
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        backgroundColor = .rehAppBackground

        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
