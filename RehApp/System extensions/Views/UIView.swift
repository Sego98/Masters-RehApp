//
//  UIView.swift
//  RehApp
//
//  Created by Akademija on 14.03.2023..
//

import UIKit

extension UIView {

    /// Method to add multiple subviews from an array
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
