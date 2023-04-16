//
//  PickerViewModel.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation

struct PickerVM {
    let title: String
    let subviews: [PickerItem]

    struct PickerItem {
        let viewModel: PickerItemVM
        let nextScreenType: NextScreenType
    }

    enum NextScreenType {
        case picker(PickerVM?)
        case list(ListAllExercisesVM?)
    }

    struct PickerItemVM {
        let title: String
        let imageName: String
    }

    // MARK: - Custom data

    static var pickPartToRehab: PickerVM {
        let title = "Rehabilitacija"
        let shoulderSubviewVM = PickerItemVM(title: "Rame", imageName: "Shoulder")
        let handSubviewVM = PickerItemVM(title: "Šaka", imageName: "Hand")
        let elbowSubview = PickerItemVM(title: "Lakat", imageName: "Elbow")
        let kneeSubview = PickerItemVM(title: "Koljeno", imageName: "Knee")

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
        return PickerVM(title: title, subviews: subviews)
    }

    static var pickShoulderExerciseType: PickerVM {
        let title = "Rame"
        let noStickSubviewVM = PickerItemVM(title: "Bez štapa", imageName: "ShoulderNoStick")
        let stickSubviewVM = PickerItemVM(title: "Sa štapom", imageName: "ShoulderWithStick")
        let subviewsVM = [
            PickerItem(viewModel: noStickSubviewVM, nextScreenType: .list(.shoulderNoStick)),
            PickerItem(viewModel: stickSubviewVM, nextScreenType: .list(.shouldersWithStick))
        ]
        return PickerVM(title: title, subviews: subviewsVM)
    }
}
