//
//  DateInputDelegate.swift
//  RehApp
//
//  Created by Akademija on 06.04.2023..
//

import Foundation

protocol DateInputDelegate: AnyObject {

    func datePicker(_ identifier: String, didSelectDate date: Date?)

}
