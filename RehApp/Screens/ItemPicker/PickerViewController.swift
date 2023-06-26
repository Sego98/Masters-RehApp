//
//  PickerViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import UIKit

final class PickerViewController: RehAppViewController {

    // MARK: - Properties

    private let pickerView = PickerView()

    private var dataSource: PickerDataSource?
    private let viewModel: PickerVM
    private var buttonActions = [UIAction?]()

//    private let testDates = [
//        DateComponents(year: 2023, month: 5, day: 15),
//        DateComponents(year: 2023, month: 5, day: 16),
//        DateComponents(year: 2023, month: 5, day: 17),
//        DateComponents(year: 2023, month: 5, day: 19),
//        DateComponents(year: 2023, month: 5, day: 20)
//    ]

    // MARK: - Lifecycle

    init(viewModel: PickerVM) {
        self.viewModel = viewModel
        super.init(screenTitle: viewModel.title, type: .exercises)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = pickerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        HealthData.shared.requestHealthAuthorization { _ in }
    }

    private func configure() {
//        let workouts: [RehabilitationWorkout] = [
//            .workout1,
//            .workout2,
//            .workout3,
//            .workout4,
//            .workout5,
//            .workout6
//        ]
//        for workout in workouts {
//            HealthData.shared.saveRehabilitation(workout) { success, _ in
//                if success {
//                    print("Saved")
//                } else {
//                    print("Fail to save")
//                }
//            }
//        }

//        for dateComponent in testDates {
//            let date = Calendar.current.date(from: dateComponent)!
//            RehAppCache.shared.createCalendarItem(date: date)
//        }

        buttonActions = makeButtonActions()
        configureDataSourceCellRegistrations()

        guard let dataSource = dataSource else { return }

        let items = viewModel.subviews.map({ $0.viewModel })
        dataSource.rebuildSnapshot(items: items, animateDifferences: true)
    }

    private func configureDataSourceCellRegistrations() {
        // swiftlint:disable:next line_length
        let cellRegistration = UICollectionView.CellRegistration<PickerCell, PickerVM.PickerItemVM> { [weak self] (cell, indexPath, item) in
            guard let self = self else { return }
            cell.setValues(with: item)

            guard viewModel.subviews.count == buttonActions.count else {
#if DEBUG
                print("‼️ There should be as many action as subviews. If there is no action, put nil.")
#endif
                return
            }

            let index = indexPath.section
            if let action = buttonActions[index] {
                cell.setButtonAction(action)
            }
        }

        dataSource = PickerDataSource(collectionView: pickerView.collectionView,
                                      cellProvider: { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: item)
        })

    }

    // MARK: - Private helper methods

    private func makeButtonActions() -> [UIAction?] {
        var actions = [UIAction?]()
        for subview in viewModel.subviews {
            let viewController: UIViewController

            switch subview.nextScreenType {
            case .picker(let pickerViewModel):
                guard let pickerViewModel = pickerViewModel else {
                    actions.append(nil)
                    continue
                }
                viewController = PickerViewController(viewModel: pickerViewModel)
            case .list(let listAllViewModel):
                guard let listAllViewModel = listAllViewModel else {
                    actions.append(nil)
                    continue
                }
                viewController = ListAllExercisesViewController(viewModel: listAllViewModel)
            }

            let action = makePushVCAction(with: viewController)
            actions.append(action)
        }
        return actions
    }

    private func makePushVCAction(with viewController: UIViewController) -> UIAction {
        return UIAction {[weak self] _ in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
