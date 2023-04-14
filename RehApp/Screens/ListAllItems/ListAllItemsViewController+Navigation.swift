//
//  ListAllItemsViewController+Navigation.swift
//  RehApp
//
//  Created by Akademija on 14.03.2023..
//

import Foundation
import UIKit

extension ListAllItemsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let title = viewModel.items[indexPath.item].title
        let description = viewModel.items[indexPath.item].longDescription
        let exerciseDetailsVM = ExerciseDetailsViewModel(screenTitle: title,
                                                         exerciseDescription: description)
        let viewController = ExerciseDetailsViewController(viewModel: exerciseDetailsVM)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
