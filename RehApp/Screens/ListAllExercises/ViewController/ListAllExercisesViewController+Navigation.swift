//
//  ListAllExercisesViewController+Navigation.swift
//  RehApp
//
//  Created by Akademija on 14.03.2023..
//

import Foundation
import UIKit

extension ListAllExercisesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.items[indexPath.item]
        let title = item.title
        let description = item.longDescription
        let url = item.videoURL
        let exerciseDetailsVM = ExerciseDetailsViewModel(screenTitle: title,
                                                         exerciseDescription: description,
                                                         videoURL: url)
        let viewController = ExerciseDetailsViewController(viewModel: exerciseDetailsVM)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
