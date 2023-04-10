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
        rebuildAllRemindersSnapshot(animatingDifferences: true)
        RehAppNotifications.shared.requestNotificationsAuthorization()
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
            let action = UIAction {[weak self] action in
                guard let self = self,
                      let switchSender = action.sender as? UISwitch,
                let reminder = RehAppCache.shared.getReminder(atIndex: indexPath.row) else { return }
                self.updateReminderAndNotificationRepeatingState(id: reminder.id, switchSender.isOn)
            }
            cell.setSwitchAction(action)
            return cell
        })
    }

    @objc private func plusButtonAction() {
        configureReminderAlert(type: .newReminder)
    }

    func rebuildAllRemindersSnapshot(animatingDifferences: Bool) {
        guard let allReminders = RehAppCache.shared.getAllReminders() else { return }
        let reminderVMs = allReminders.compactMap({ $0.viewModel })
        // Added deadline to avoid autolayout issues
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {[weak self] in
            self?.dataSource?.rebuildSnapshot(reminders: reminderVMs, animatingDifferences: animatingDifferences)
        }
    }

    func createNewReminderAndNotification() {
        let id = UUID()
        createNewReminderFromAlert(id: id)
        RehAppNotifications.shared.scheduleReminderNotification(with: id)
        rebuildAllRemindersSnapshot(animatingDifferences: true)
    }

    func updateReminderAndNotification(id: UUID?) {
        guard let id = id else { return }
        updateReminderFromAlert(id: id)
        RehAppNotifications.shared.scheduleReminderNotification(with: id)
        rebuildAllRemindersSnapshot(animatingDifferences: true)
    }

    func updateReminderAndNotificationRepeatingState(id: UUID?, _ isRepeating: Bool) {
        guard let id = id else { return }
        RehAppCache.shared.updateReminder(id: id, isRepeating: isRepeating)
        RehAppNotifications.shared.scheduleReminderNotification(with: id)
    }

    func deleteReminderAndNotification(id: UUID?) {
        guard let id = id else { return }
        RehAppCache.shared.deleteReminder(id: id)
        RehAppNotifications.shared.removeReminderNotification(with: id)
        rebuildAllRemindersSnapshot(animatingDifferences: true)
    }

}

extension RemindersViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reminder = RehAppCache.shared.getReminder(atIndex: indexPath.row) else { return }
        configureReminderAlert(type: .editingReminder, reminder: reminder.viewModel)
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "Obriši") {[weak self] _, _, _ in
            guard let self = self else { return }
            guard let reminder = RehAppCache.shared.getReminder(atIndex: indexPath.row) else { return }
            self.deleteReminderAndNotification(id: reminder.id)
        }
        deleteAction.image = UIImage(systemName: "trash")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

}
