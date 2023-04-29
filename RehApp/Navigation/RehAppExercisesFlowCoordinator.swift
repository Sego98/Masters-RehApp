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

        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "stop.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(stopButtonAction))

        viewController.setLeftBarButton(leftBarButton)
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
            showFinishRehabilitationAlert()
        }
        show(viewController)
    }

    // MARK: - Alerts

    private func showFinishRehabilitationAlert() {
        let numberOfRemainingExercises = exerciseViewModels.count - selectedIndex - 1

        if selectedIndex < exerciseViewModels.count - 1 {
            selectedIndex += 1
            let message = """
            Uspješno si odradio i ovu vježbu. Uzmi kratki predah i nastavi dalje. \
            \n\n⏳ Broj preostalih vježbi: \(numberOfRemainingExercises)
            """
            let alertAction = UIAlertAction(title: "Nastavi",
                                        style: .default,
                                        handler: { [weak self] _ in
                guard let self = self else { return }
                showExerciseDetailsScreen()
            })
            SoundPlayer.shared.playSound(.singleExerciseFinished)
            let alert = makeAlert(title: "Bravo!", message: message, preferredStyle: .alert, actions: [alertAction])

            navigationController?.present(alert, animated: true)
        } else {
            SoundPlayer.shared.playSound(.allExercisesFinished)
            saveRehabilitation()
        }
    }

    func showFinishButtonAlert() {
        let dismissAction = UIAlertAction(title: "Odustani", style: .default) { [weak self] _ in
            guard let self = self else { return }
        }
        let finishAndDontSaveAction = UIAlertAction(title: "Završi bez spremanja rehabilitacije",
                                                    style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
        let finishAndSaveAction = UIAlertAction(title: "Završi i spremi rehabilitaciju",
                                                style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            saveRehabilitation()
            navigationController?.popToRootViewController(animated: true)
        }
        let alertActions = [dismissAction, finishAndDontSaveAction, finishAndSaveAction]

        let alert = makeAlert(title: "Završi",
                              message: "Jesi li siguran da želiš završiti svoju rehabilitaciju?",
                              preferredStyle: .alert,
                              actions: alertActions)

        navigationController?.present(alert, animated: true)
    }

    private func showRehabilitationSavedSuccessfullyAlert() {
        let message = "Uspješno si odradio svoje vježbe i podaci su spremljeni u aplikaciji Zdravlje! 🏆"
        let alertAction = UIAlertAction(title: "Završi",
                                    style: .default,
                                    handler: { [weak self] _ in
            guard let self = self else { return }
            navigationController?.popToRootViewController(animated: true)
        })
        let alert = makeAlert(title: "Bravo!", message: message, preferredStyle: .alert, actions: [alertAction])
        navigationController?.present(alert, animated: true)
    }

    private func showRehabilitationFailedToSaveAlert() {
        let dismissAction = UIAlertAction(title: "Završi", style: .default) { [weak self] _ in
            guard let self = self else { return }
            navigationController?.popToRootViewController(animated: true)
        }
        let alert = makeAlert(title: "Rehabilitacija nije spremljena",
                              message: """
        😕 Odlično si odradio svoju rehabilitaciju, ali nažalost podaci nisu spremljeni u aplikaciju zdravlje. \
        Rehabilitacija mora trajati barem jednu minutu kako bi se spremila i aplikacija mora imati \
        dozvolu da upisuje i čita sadržaj svih potrebnih komponenti u aplikaciji Zdravlje
        """,
                              preferredStyle: .alert,
                              actions: [dismissAction])

        navigationController?.present(alert, animated: true)
    }

    // MARK: - Helper methods

    private func saveRehabilitation() {
        let endTime = Date()
        let rehabilitation = RehabilitationWorkout(start: startTime, end: endTime)
        HealthData.shared.requestHealthAuthorization { success in
            if success {
                HealthData.shared.saveRehabilitation(rehabilitation) { [weak self] (success, error) in
                    guard let self = self else { return }
                    if success {
                        let endTimeDateComponents = Calendar.current.dateComponents([.year, .month, .day],
                                                                                    from: endTime)
                        if let date = Calendar.current.date(from: endTimeDateComponents) {
                            RehAppCache.shared.createCalendarItem(date: date)
                        }

                        DispatchQueue.main.async {
                            self.showRehabilitationSavedSuccessfullyAlert()
                        }
#if DEBUG
                        print("💾 Workout saved successfully")
#endif
                    } else {
                        DispatchQueue.main.async {
                            self.showRehabilitationFailedToSaveAlert()
                        }
#if DEBUG
                        if let error = error {
                            print("❌ Workout failed to save with error \(error.localizedDescription)")
                        }
#endif
                    }
                }
            }
        }
    }

    private func makeAlert(title: String,
                           message: String,
                           preferredStyle: UIAlertController.Style,
                           actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: preferredStyle)
        actions.forEach {
            alert.addAction($0)
        }

        return alert
    }

    @objc func stopButtonAction() {
        showFinishButtonAlert()
    }

}
