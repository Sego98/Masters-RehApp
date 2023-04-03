//
//  RemindersViewController.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//
// swiftlint:disable line_length

import Foundation
import UIKit

final class RemindersViewController: RehAppViewController {

    // MARK: - Properties

    private let remindersView = RemindersView()

    private var dataSource: RemindersDataSource!

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
    }

    private func configure() {
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

    // MARK: - Core data methods

    private func getAllReminders() {
        let reminderFetchRequest = CDReminder.fetchRequest()
        do {
            let _ = try mainViewContext.fetch(reminderFetchRequest)
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }

    private func createReminder(name: String, date: Date) {
        let reminder = CDReminder(context: mainViewContext)
        reminder.name = name
        reminder.date = date
        saveMainContext()
    }

    private func deleteReminder(_ reminder: CDReminder) {
        mainViewContext.delete(reminder)
        saveMainContext()
    }

    private func updateReminder(_ reminder: CDReminder, newName: String, newDate: Date) {
        reminder.name = newName
        reminder.date = newDate
        saveMainContext()
    }

    // MARK: - Private helper methods

    private func saveMainContext() {
        do {
            try mainViewContext.save()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
    }
}
