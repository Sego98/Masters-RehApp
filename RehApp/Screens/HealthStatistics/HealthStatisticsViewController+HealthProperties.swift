//
//  HealthStatisticsViewController+HealthProperties.swift
//  RehApp
//
//  Created by Akademija on 12.04.2023..
//

import Foundation
import UIKit
import HealthKit

extension HealthStatisticsViewController {

    func setUserName() {
        healthStatisticsView.setName("Petar Ljubotina")
    }

    func setUserHeightFromHealthData() {
        getQuantityValueFromHealth(for: .height) {[weak self] (height) in
            guard let self = self else { return }
            guard let height = height else {
                self.healthStatisticsView.setHeight(nil)
                return
            }
            self.healthStatisticsView.setHeight(Measurement(value: height, unit: .meters))
        }
    }

    func setUserMassFromHealthData() {
        getQuantityValueFromHealth(for: .bodyMass) { [weak self] (mass) in
            guard let self = self else { return }
            guard let mass = mass else {
                self.healthStatisticsView.setMass(nil)
                return
            }
            self.healthStatisticsView.setMass(Measurement(value: mass, unit: .grams))
        }
    }

    // MARK: - Helper methods

    private func getQuantityValueFromHealth(for identifier: HKQuantityTypeIdentifier,
                                            completion: @escaping (Double?) -> Void) {
        HealthData.shared.getMostRecentQuantitySample(for: identifier) { height, error in
            if let error = error {
#if DEBUG
                print("No value, \(error.localizedDescription)")
#endif
                completion(nil)
            }
            completion(height)
        }
    }
}
