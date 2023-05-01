//
//  String.swift
//  RehApp
//
//  Created by Petar Ljubotina on 01.05.2023..
//

import Foundation

extension String {

    func localize(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

}
