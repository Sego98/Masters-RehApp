//
//  ListAllItemsViewController+Navigation.swift
//  RehApp
//
//  Created by Akademija on 14.03.2023..
//

import Foundation
import UIKit

extension ListAllItemsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListAllItemsCell else { return }
        cell.setBackgroundColor(.lightPurple.withAlphaComponent(0.2))
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ListAllItemsCell else { return }
        cell.setBackgroundColor(.rehAppBackground)
    }
}
