//
//  String.swift
//  RehApp
//
//  Created by Akademija on 01.05.2023..
//

import Foundation

extension String {

    func localize(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
