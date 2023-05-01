//
//  ExerciseDetailsViewModel.swift
//  RehApp
//
//  Created by Akademija on 16.03.2023..
//

import Foundation

struct ExerciseDetailsVM: Hashable, Equatable {
    let title: String
    let shortDescription: String
    let longDescription: String
    let oneRepetitionTime: TimeInterval
    let videoURL: URL?

    private static let mockOneRepetitionTime: TimeInterval = 2
    private static let mockURL = URL(string: "https://www.youtube.com/watch?v=t99KH0TR-J4")

    // MARK: - Shoulder exercises without stick 

    static let shoulderExerciseWithoutStick1: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "ShoulderLift".localize(),
                                 shortDescription: "ShoulderRaiseUp".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription1".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick2: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "CirclingShoulders".localize(),
                                 shortDescription: "RollingShouldersForward".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription2".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick3: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "CirclingShoulders".localize(),
                                 shortDescription: "CirclingShouldersBackwards".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription3".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick4: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "SpreadingHands".localize(),
                                 shortDescription: "ExtendingArmsFromBody".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription4".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick5: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "LiftingArms".localize(),
                                 shortDescription: "RaisingHandsJoiningForwards".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription5".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick6: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StretchingHands".localize(),
                                 shortDescription: "StretchingHandsBackwards".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription6".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick7: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StretchingHands".localize(),
                                 shortDescription: "StretchingHandsForwards".localize(),
                                 longDescription: "ShoulderExerciseNoStickDescription7".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    // MARK: - Shoulder exercises with stick

    static let shoulderExerciseWithStick1: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Podizanje štapa",
                                 shortDescription: "Primiti štap u širini ramena",
                                 longDescription: """
                Primite štap s opuštenim ispruženim rukama u širini ramena. Štap podižite prema gore \
                koliko god je moguće. Cilj vježbe je da se štap može spustiti na vrat iza glava, ali \
                to se ne smije forsirati!
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick2: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Podizanje štapa",
                                 shortDescription: "Primiti štap na krajevima",
                                 longDescription: """
                Primite štap s opuštenim ispruženim rukama na krajevima. Štap podižite prema gore \
                koliko god je moguće. Cilj vježbe je da se štap može spustiti na vrat iza glava, ali \
                to se ne smije forsirati!
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick3: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Povlačenje štapa",
                                 shortDescription: "Primiti štap u visini ramena i povlačiti prema bradi",
                                 longDescription: """
                Primite štap s ispruženim rukama u visini ramena. Štap držite u tom položaju i privlačite \
                ga prema bradi. Lakat i rame cijelo vrijeme ostaju u istoj visini.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick4: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Istezanje zasucima",
                                 shortDescription: "Primiti štap na krajevima i istezati se rotacijama",
                                 longDescription: """
                Primite štap na krajeve s ispruženim rukama u visini ramena. Radite zasuke u lijevu i desnu stranu \
                kako biste istegnuli leđa. Jedan lakat se savija, a drugi se pruža u stranu.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick5: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Štap iza leđa",
                                 shortDescription: "Primiti štap iza leđa i odmicati ga",
                                 longDescription: """
                Primite štap iza leđa u donjem dijelu i odmičite ga od sebe što je više moguće
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick6: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Štap iza leđa",
                                 shortDescription: "Primiti štap iza leđa i povlačiti ga",
                                 longDescription: """
                Primite štap iza leđa u donjem dijelu i povlačite ga prema lopaticama što je više moguće
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

}
