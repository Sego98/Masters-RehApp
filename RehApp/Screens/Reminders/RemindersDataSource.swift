//
//  RemindersDataSource.swift
//  RehApp
//
//  Created by Akademija on 03.04.2023..
//

import Foundation
import UIKit

final class RemindersDataSource: UITableViewDiffableDataSource<Int, ReminderVM> {

    typealias RemindersSnapshot = NSDiffableDataSourceSnapshot<Int, ReminderVM>

    func rebuildSnapshot(reminders: [ReminderVM], animatingDifferences: Bool) {
        var snapshot = RemindersSnapshot()

        snapshot.appendSections([0])
        snapshot.appendItems(reminders, toSection: 0)
        snapshot.reloadItems(reminders)

        applyOnMainThread(snapshot: snapshot, animatingDifferences: animatingDifferences)
    }

    func applyOnMainThread(snapshot: RemindersSnapshot, animatingDifferences: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.apply(snapshot, animatingDifferences: animatingDifferences)
        }
    }
}
