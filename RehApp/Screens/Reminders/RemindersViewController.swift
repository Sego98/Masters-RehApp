//
//  RemindersViewController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit
import CoreData

final class RemindersViewController: RehAppViewController {

    // MARK: - Properties

    private let remindersView = RemindersView()
    private var dataSource: RemindersDataSource?

    var presentedAlert: UIAlertController?
    var submitAction: UIAlertAction?
    var allReminders = [CDReminder]()

    // MARK: - Lifecycle

    init() {
        super.init(screenTitle: "Podsjetnici", type: .reminders)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = remindersView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDataSource()
        getAllReminders()
    }

    private func configure() {
        navigationItem.rightBarButtonItem?.action = #selector(plusButtonAction)
        remindersView.tableView.delegate = self
    }

    private func configureDataSource() {
        remindersView.tableView.register(ReminderCell.self, forCellReuseIdentifier: ReminderCell.identifier)

        dataSource = RemindersDataSource(tableView: remindersView.tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.identifier, for: indexPath) as? ReminderCell else {
                // Error cell
                let cell = UITableViewCell()
                cell.backgroundColor = .red
                return cell
            }
            cell.setValues(with: item)
            return cell
        })
    }

    @objc private func plusButtonAction() {
        configureReminderAlert(type: .newReminder)
    }

    func rebuildSnapshot(reminders: [ReminderVM], animatingDifferences: Bool) {
        dataSource?.rebuildSnapshot(reminders: reminders, animatingDifferences: animatingDifferences)
    }

}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedReminder = allReminders[indexPath.row]
        print(selectedReminder)
        configureReminderAlert(type: .editingReminder, reminder: selectedReminder)
    }

}
