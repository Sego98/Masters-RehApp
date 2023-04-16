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
                  rightHeaderDescription: String = "Opis",
                  exercises: [ExerciseDetailsVM],
                  largeButtonTitle: String = "Nastavi") {
        self.screenTitle = screenTitle
        self.screenDescription = screenDescription
        self.leftHeaderDescription = leftHeaderDescription
        self.rightHeaderDescription = rightHeaderDescription
        self.exercises = exercises
        self.largeButtonTitle = largeButtonTitle
    }

    // MARK: - Shoulder exercises without a stick

    static var shoulderNoStick: ListAllExercisesVM {
        let screenTitle = "Vježbe ramena"
        let screenDescription = """
        Na ekranu su prikazane sve vježbe za rehabilitaciju ramena koje možete raditi bez bilo kakvih pomagala. \
        Klikom na pojedinu vježbu pogledajte detalje i izvedbu u obliku slike i videa.
        """

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
        let screenTitle = "Vježbe ramena"
        let screenDescription = """
        Na ekranu su prikazane sve vježbe za rehabilitaciju ramena koje morate raditi sa štapom ili nekim sličnim \
        predmetom. Klikom na pojedinu vježbu pogledajte detalje i izvedbu u obliku slike i videa.
        """

        let exercises: [ExerciseDetailsVM]  = [
            .shoulderExerciseWithStick1,
            .shoulderExerciseWithStick2,
            .shoulderExerciseWithStick3
        ]

        return ListAllExercisesVM(screenTitle: screenTitle,
                                  screenDescription: screenDescription,
                                  exercises: exercises)
    }
}
