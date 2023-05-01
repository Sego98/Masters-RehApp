//
//  NumberOfRepetitionsPickerDataSource.swift
//  RehApp
//
//  Created by Petar Ljubotina on 15.04.2023..
//

import Foundation
import UIKit

final class NumberOfRepetitionsPickerDataSource: NSObject, UIPickerViewDataSource {

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
