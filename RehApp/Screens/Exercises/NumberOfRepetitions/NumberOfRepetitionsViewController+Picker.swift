//
//  NumberOfRepetitionsViewController+Picker.swift
//  RehApp
//
//  Created by Petar Ljubotina on 15.04.2023..
//

import Foundation
import UIKit

extension NumberOfRepetitionsViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(numberOfRepetitions[row])
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let numberSelected = numberOfRepetitions[row]
        UserDefaults.standard.set(numberSelected, forKey: GlobalSettings.numberOfRepetitionsSelectedKey)
    }

}
