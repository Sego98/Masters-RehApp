//
//  ExerciseDetailsDelegate.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation

protocol ExerciseDetailsDelegate: AnyObject {

    func makeExerciseDetailsViewModels() -> [ExerciseDetailsViewModel]

}
