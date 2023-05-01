//
//  UIFont.swift
//  RehApp
//
//  Created by Petar Ljubotina on 08.04.2023..
//

import Foundation
import UIKit

extension UIFont {

    static func preferredFont(for style: UIFont.TextStyle, trait: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let systemFont = UIFont.systemFonts[style]!
//        let description = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: systemFont.pointSize,
                                     weight: trait)
        return metrics.scaledFont(for: font)
    }

    static let systemFonts: [UIFont.TextStyle: UIFont] = [
        .largeTitle: .systemFont(ofSize: 34),
        .title1: .systemFont(ofSize: 28),
        .title2: .systemFont(ofSize: 22),
        .title3: .systemFont(ofSize: 20),
        .headline: .systemFont(ofSize: 17),
        .body: .systemFont(ofSize: 17),
        .callout: .systemFont(ofSize: 16),
        .subheadline: .systemFont(ofSize: 15),
        .footnote: .systemFont(ofSize: 13),
        .caption1: .systemFont(ofSize: 12),
        .caption2: .systemFont(ofSize: 11)
    ]

}
