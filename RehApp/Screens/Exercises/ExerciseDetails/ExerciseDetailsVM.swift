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
        return ExerciseDetailsVM(title: "Podizanje ramena",
                                 shortDescription: "Podizanje ramena prema gore",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ramena lagano podižu \
                prema gore. Kada se dođe u gornju poziciju, potrebno je zadržati položaj dvije sekunde.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick2: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Kruženje ramenima",
                                 shortDescription: "Kruženje ramenima prema naprijed",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ramenima lagano \
                kruži. Ramenima kružite prema naprijed uz lagano zadržavanje u gornjem položaju.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick3: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Kruženje ramenima",
                                 shortDescription: "Kruženje ramenima prema nazad",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ramenima lagano \
                kruži. Ramenima kružite prema nazad uz lagano zadržavanje u gornjem položaju.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick4: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Širenje ruku",
                                 shortDescription: "Širenje ruku od tijela",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ispružene ruke \
                podižu od tijela i skupljaju iznad glave. Potom se ruke vraćaju istim putem nazad.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick5: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Podizanje ruku",
                                 shortDescription: "Podizanje ruku i spajanje ispred sebe",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ispružene ruke \
                podižu od tijela sve dok ne budu u istoj ravnini. Zatim se ruke rotiraju tako da se \
                zajedno skupe ispred prsa. Nakon toga se vraćaju tako da prvo dođu ispružene u istu \
                ravninu i potom se spuštaju uz tijelo.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick6: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Istezanje ruku",
                                 shortDescription: "Istezanje ruku prema nazad",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ispružene ruke \
                lagano podižu i spajaju iza leđa. Cilj je istezati ramena tako da se lopatice spajaju.
                """,
                                 oneRepetitionTime: mockOneRepetitionTime,
                                 videoURL: mockURL)
    }()

    static let shoulderExerciseWithoutStick7: ExerciseDetailsVM = {
        return ExerciseDetailsVM(title: "Istezanje ruku",
                                 shortDescription: "Istezanje ruku prema naprijed",
                                 longDescription: """
                Ruke se nalaze potpuno opušteno uz tijelo. Vježba se izvodi tako da se ruke ispruže \
                ispred prsa i prsti isprepletu. U tom pložaju potrebno je ruke istegnuti prema naprijed. \
                Nakon istezanje ruke se tako spojene podižu iznad glave.
                """,
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
