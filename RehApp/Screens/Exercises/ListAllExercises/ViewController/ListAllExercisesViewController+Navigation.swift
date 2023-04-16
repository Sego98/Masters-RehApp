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
        let viewController = ExerciseDetailsViewController(viewModel: viewModel.exercises[indexPath.item],
                                                           showDetailsVideo: true)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
