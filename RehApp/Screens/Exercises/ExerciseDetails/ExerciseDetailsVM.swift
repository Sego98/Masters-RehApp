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
        return ExerciseDetailsVM(title: "StickLifting".localize(),
                                 shortDescription: "StickShoulderWidth".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription1".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick2: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StickLifting".localize(),
                                 shortDescription: "GrabStickEnd".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription2".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick3: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "PullingStick".localize(),
                                 shortDescription: "PullingStickShoulderHeight".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription3".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick4: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StretchingWithCurls".localize(),
                                 shortDescription: "StickEndRotate".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription4".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick5: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StickBehindBack".localize(),
                                 shortDescription: "StickBehindBackMoveAway".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription5".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithStick6: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "StickBehindBack".localize(),
                                 shortDescription: "StickBehindBackPull".localize(),
                                 longDescription: "ShoulderExerciseWithStickDescription6".localize(),
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

}
