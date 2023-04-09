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
    var wheelsTimePicker: WheelsTimePicker?
    var allReminderIDs = [UUID]()

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
        requestNotificationsAuthorization()
        getAllReminders()
    }

    private func configure() {
        navigationItem.rightBarButtonItem?.action = #selector(plusButtonAction)
        remindersView.tableView.delegate = self
    }

    private func configureDataSource() {
        remindersView.tableView.register(ReminderCell.self,
                                         forCellReuseIdentifier: ReminderCell.identifier)

        dataSource = RemindersDataSource(tableView: remindersView.tableView, cellProvider: { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderCell.identifier, for: indexPath) as? ReminderCell else {
                // Error cell
                let cell = UITableViewCell()
                cell.contentView.backgroundColor = .red
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
        let reminderID = allReminderIDs[indexPath.row]
        guard let reminder = getReminder(id: reminderID) else { return }
        configureReminderAlert(type: .editingReminder, reminder: reminder.viewModel)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Obriši") {[weak self] _, _, _ in
            guard let self = self else { return }
            let reminderID = self.allReminderIDs[indexPath.row]
            self.deleteReminder(id: reminderID)
            self.removeReminderNotification(with: reminderID)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
