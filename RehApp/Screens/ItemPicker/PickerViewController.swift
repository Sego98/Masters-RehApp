//
//  PickerViewController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import UIKit

final class PickerViewController: RehAppViewController {

    // MARK: - Properties

    private let pickerView: PickerView

    private let viewModel: PickerViewModel

    // MARK: - Lifecycle

    init(viewModel: PickerViewModel) {
        self.viewModel = viewModel

        var subviews = [PickerViewModel.PickerItemViewModel]()
        for subview in viewModel.subviews {
            subviews.append(subview.viewModel)
        }

        self.pickerView = PickerView(subviewsVM: subviews)
        super.init(screenTitle: viewModel.title)
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

    private func configure() {

        let buttonActions = makeButtonActions()
        pickerView.setButtonActions(buttonActions)
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
                viewController = ListAllItemsViewController(viewModel: listAllViewModel)
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
