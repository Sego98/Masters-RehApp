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

    private let exerciseViewModels: [ExerciseDetailsViewModel]
    private let navigationController: UINavigationController?
    private let animated: Bool

    private let selectedIndex: Int
    private var currentExerciseDetailsVC: ExerciseDetailsViewController?

    private let disposeBag = DisposeBag()

    private let countdownTimer = Observable<Int>
        .interval(.seconds(1), scheduler: MainScheduler.instance)
        .take(3)
        .observe(on: MainScheduler.instance)

    // MARK: - Init

    init(exerciseViewModels: [ExerciseDetailsViewModel],
         navigationController: UINavigationController?,
         animated: Bool = true) {
        self.exerciseViewModels = exerciseViewModels
        self.navigationController = navigationController
        self.animated = animated
        selectedIndex = 0

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
                                                           showDetailsVideo: false)
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
            .subscribe(onCompleted: {
                viewController.timerDidFinish()
                print("Successssssssss")
            }).disposed(by: disposeBag)
    }
}
