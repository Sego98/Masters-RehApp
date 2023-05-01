//
//  ListAllExercisesVM.swift
//  RehApp
//
//  Created by Petar Ljubotina on 11.03.2023..
//

import Foundation

struct ListAllExercisesVM: Hashable, Equatable {
    let screenTitle: String
    let screenDescription: String
    let leftHeaderDescription: String
    let rightHeaderDescription: String
    let exercises: [ExerciseDetailsVM]
    let largeButtonTitle: String

    internal init(screenTitle: String,
                  screenDescription: String,
                  leftHeaderDescription: String = "#",
                  rightHeaderDescription: String = "Description".localize(),
                  exercises: [ExerciseDetailsVM],
                  largeButtonTitle: String = "Proceed".localize()) {
        self.screenTitle = screenTitle
        self.screenDescription = screenDescription
        self.leftHeaderDescription = leftHeaderDescription
        self.rightHeaderDescription = rightHeaderDescription
        self.exercises = exercises
        self.largeButtonTitle = largeButtonTitle
    }

    // MARK: - Shoulder exercises without a stick

    static var shoulderNoStick: ListAllExercisesVM {
        let screenTitle = "ShoulderExercises".localize()
        let screenDescription = "ShoulderNoStickExercisesDescription".localize()

        let exercises: [ExerciseDetailsVM] = [
            .shoulderExerciseWithoutStick1,
            .shoulderExerciseWithoutStick2,
            .shoulderExerciseWithoutStick3,
            .shoulderExerciseWithoutStick4,
            .shoulderExerciseWithoutStick5,
            .shoulderExerciseWithoutStick6,
            .shoulderExerciseWithoutStick7
        ]

        return ListAllExercisesVM(screenTitle: screenTitle,
                                  screenDescription: screenDescription,
                                  exercises: exercises)
    }

    // MARK: - Shoulder exercises with a stick

    static var shouldersWithStick: ListAllExercisesVM {
        let screenTitle = "ShoulderExercises".localize()
        let screenDescription = "ShoulderWithStickExercisesDescription".localize()

        let exercises: [ExerciseDetailsVM]  = [
            .shoulderExerciseWithStick1,
            .shoulderExerciseWithStick2,
            .shoulderExerciseWithStick3,
            .shoulderExerciseWithStick4,
            .shoulderExerciseWithStick5,
            .shoulderExerciseWithStick6
        ]

        return ListAllExercisesVM(screenTitle: screenTitle,
                                  screenDescription: screenDescription,
                                  exercises: exercises)
    }
}
