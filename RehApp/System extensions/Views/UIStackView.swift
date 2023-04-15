//
//  UIStackView.swift
//  RehApp
//
//  Created by Akademija on 14.03.2023..
//

import UIKit

extension UIStackView {

    /// Method to add multiple arranged subviews from an array
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
}
