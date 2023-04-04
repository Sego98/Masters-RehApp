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

//    private let mainViewContext: NSManagedObjectContext

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
//        createReminder(name: "Test", date: Date())
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

        getAllReminders()
    }

    // MARK: - Core data methods

    private func getAllReminders() {
        let reminderFetchRequest = CDReminder.fetchRequest()
        do {
            let reminders = try mainViewContext.fetch(reminderFetchRequest)
            print(reminders.count)
            guard let dataSource = dataSource else { return }
            let remindersVM = reminders.compactMap { $0.viewModel }
            dataSource.rebuildSnapshot(reminders: remindersVM, animatingDifferences: true)
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
        do {
            try mainViewContext.save()
        } catch {
#if DEBUG
            print(error.localizedDescription)
#endif
        }
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
