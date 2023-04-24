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

//    func setUserName() {
//        healthStatisticsView.setName("Petar Ljubotina")
//    }

    func getAllRehabilitationWorkouts() {
        HealthData.shared.fetchAllRehabilitations { workouts, error in
//            guard let workouts = workouts,
//                  error == nil else { return }
        }
    }

    // MARK: - Helper methods

    private func getQuantityValueFromHealth(for identifier: HKQuantityTypeIdentifier,
                                            completion: @escaping (Double?) -> Void) {
        HealthData.shared.fetchMostRecentQuantitySample(for: identifier) { height, error in
            DispatchQueue.main.async {
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
}
