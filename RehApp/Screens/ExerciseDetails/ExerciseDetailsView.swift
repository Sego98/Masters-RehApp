//
//  ExerciseDetailsView.swift
//  RehApp
//
//  Created by Petar Ljubotina on 16.03.2023..
//

import Foundation
import UIKit

class ExerciseDetailsView: UIView {

    // MARK: - Init

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    func activateOverlayView() {
//        overlayView.timerLabel.text = "3"
//        addSubview(overlayView)
//        largeButton.isEnabled = false
//
//        NSLayoutConstraint.activate([
//            overlayView.topAnchor.constraint(equalTo: topAnchor),
//            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
//    }
//
//    func deactivateOverlayView() {
//        overlayView.removeFromSuperview()
//        largeButton.isEnabled = true
//    }
}
