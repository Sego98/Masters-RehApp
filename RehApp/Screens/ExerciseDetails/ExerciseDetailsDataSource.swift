//
//  ExerciseDetailsDataSource.swift
//  RehApp
//
//  Created by Akademija on 16.03.2023..
//

import Foundation
import UIKit

final class ExerciseDetailsPickerDataSource: NSObject, UIPickerViewDataSource {

    let numberOfRepetitions: [Int]

    init(numberOfRepetitions: [Int]) {
        self.numberOfRepetitions = numberOfRepetitions
        super.init()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfRepetitions.count
    }
}
