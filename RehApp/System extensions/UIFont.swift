//
//  UIFont.swift
//  RehApp
//
//  Created by Akademija on 08.04.2023..
//

import Foundation
import UIKit

extension UIFont {

    static func preferredFont(for style: UIFont.TextStyle, trait: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let description = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: description.pointSize,
                                     weight: trait)
        return metrics.scaledFont(for: font)
    }

}
