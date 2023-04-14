//
//  PickerViewModel.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation

struct PickerViewModel {
    let title: String
    let subviews: [PickerItem]

    struct PickerItem {
        let viewModel: PickerItemViewModel
        let nextScreenType: NextScreenType
    }

    enum NextScreenType {
        case picker(PickerViewModel?)
        case list(ListAllExercisesVM?)
    }

    struct PickerItemViewModel {
        let title: String
        let imageName: String
    }

    // MARK: - Custom data

    static var pickPartToRehab: PickerViewModel {
        let title = "Rehabilitacija"
        let shoulderSubviewVM = PickerItemViewModel(title: "Rame", imageName: "Shoulder")
        let handSubviewVM = PickerItemViewModel(title: "Šaka", imageName: "Hand")
        let elbowSubview = PickerItemViewModel(title: "Lakat", imageName: "Elbow")
        let kneeSubview = PickerItemViewModel(title: "Koljeno", imageName: "Knee")

        let subviews = [
            PickerItem(viewModel: shoulderSubviewVM,
                       nextScreenType: .picker(.pickShoulderExerciseType)),
            PickerItem(viewModel: handSubviewVM,
                       nextScreenType: .list(nil)),
            PickerItem(viewModel: elbowSubview,
                       nextScreenType: .list(nil)),
            PickerItem(viewModel: kneeSubview,
                       nextScreenType: .list(nil))
        ]
        return PickerViewModel(title: title, subviews: subviews)
    }

    static var pickShoulderExerciseType: PickerViewModel {
        let title = "Rame"
        let noStickSubviewVM = PickerItemViewModel(title: "Bez štapa", imageName: "ShoulderNoStick")
        let stickSubviewVM = PickerItemViewModel(title: "Sa štapom", imageName: "ShoulderWithStick")
        let subviewsVM = [
            PickerItem(viewModel: noStickSubviewVM, nextScreenType: .list(.shoulderNoStick)),
            PickerItem(viewModel: stickSubviewVM, nextScreenType: .list(.shouldersWithStick))
        ]
        return PickerViewModel(title: title, subviews: subviewsVM)
    }
}
