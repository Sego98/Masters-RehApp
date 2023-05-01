//
//  RehAppNavigationController.swift
//  RehApp
//
//  Created by Petar Ljubotina on 03.04.2023..
//

import Foundation
import UIKit

class RehAppNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .lightContent
    }

}
