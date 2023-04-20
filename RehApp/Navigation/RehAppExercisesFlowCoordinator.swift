//
//  RehAppExercisesFlowCoordinator.swift
//  RehApp
//
//  Created by Akademija on 15.04.2023..
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class RehAppExercisesFlowCoordinator {

    // MARK: - Properties

    private let exerciseViewModels: [ExerciseDetailsVM]
    private let navigationController: UINavigationController?
    private let animated: Bool

    private var selectedIndex: Int
    private var currentExerciseDetailsVC: ExerciseDetailsViewController?

    private let disposeBag = DisposeBag()

    private let countdownTimer = Observable<Int>
        .interval(.seconds(1), scheduler: MainScheduler.instance)
        .take(3)
        .observe(on: MainScheduler.instance)

    private let startTime: Date

    // MARK: - Init

    init(exerciseViewModels: [ExerciseDetailsVM],
         navigationController: UINavigationController?,
         animated: Bool = true) {
        self.exerciseViewModels = exerciseViewModels
        self.navigationController = navigationController
        self.animated = animated
        selectedIndex = 0
        startTime = Date()

        showFirstScreen()
    }

    // MARK: - Flow methods

    private func show(_ viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    private func showFirstScreen() {
        showExerciseDetailsScreen()
    }

    private func showExerciseDetailsScreen() {
        guard selectedIndex < exerciseViewModels.count else {
            fatalError("Index exceeds an array. Take care of this.")
        }
        let viewModel = exerciseViewModels[selectedIndex]
        let viewController = ExerciseDetailsViewController(viewModel: viewModel,
                                                           isExercisingInProgress: true)
        let action = UIAction { _ in
            self.startOverlayTimer()
        }

        viewController.setLargeButtonAction(action)
        currentExerciseDetailsVC = viewController
        show(viewController)
    }

    private func startOverlayTimer() {
        guard let viewController = currentExerciseDetailsVC else {
            fatalError("No exercise details viewController")
        }
        viewController.startTimer()

        let timerLabel = viewController.getOverlayTimerLabel()

        countdownTimer
            .map { "\(2 - $0)"}
            .bind(to: timerLabel.rx.text)
            .disposed(by: disposeBag)

        countdownTimer
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                viewController.timerDidFinish()
                showExerciseCounterScreen()
            }).disposed(by: disposeBag)
    }

    private func showExerciseCounterScreen() {
        let viewModel = exerciseViewModels[selectedIndex]
        let viewController = ExerciseCounterViewController(exerciseVM: viewModel) { [weak self] in
            guard let self = self else { return }
            showFinishAlert()
        }
        show(viewController)
    }

    private func showFinishAlert() {
        let numberOfRemainingExercises = exerciseViewModels.count - selectedIndex - 1

        let message: String
        let alertAction: UIAlertAction
        if selectedIndex < exerciseViewModels.count - 1 {
            selectedIndex += 1
            message = """
            Uspješno si odradio i ovu vježbu. Uzmi kratki predah i nastavi dalje. \
            \n\n⏳ Broj preostalih vježbi: \(numberOfRemainingExercises)
            """
            alertAction = UIAlertAction(title: "Nastavi",
                                        style: .default,
                                        handler: { [weak self] _ in
                guard let self = self else { return }
                showExerciseDetailsScreen()
            })
            SoundPlayer.shared.playSound(.singleExerciseFinished)
        } else {
            message = "Još jedan dan kada si odradio sve vježbe. Sada je vrijeme da se zasluženo odmoriš! 🏆"
            alertAction = UIAlertAction(title: "Završi",
                                        style: .default,
                                        handler: { [weak self] _ in
                guard let self = self else { return }
                navigationController?.popToRootViewController(animated: true)
            })
            SoundPlayer.shared.playSound(.allExercisesFinished)
            let endTime = Date()
            let rehabilitation = RehabilitationWorkout(start: startTime, end: endTime)
            HealthData.shared.saveWorkout(rehabilitation) { success, error in
                if success {
#if DEBUG
                    print("Workout saved successfully")
#endif
                } else {
#if DEBUG
                    print("Workout failed to save with error \(error?.localizedDescription as Any)")
#endif
                }
            }
        }

        let alert = UIAlertController(title: "Bravo!",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(alertAction)

        navigationController?.present(alert, animated: true)
    }
}
