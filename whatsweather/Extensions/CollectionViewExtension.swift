//
//  CollectionViewExtension.swift
//  whatsweather
//
//  Created by tunay alver on 8.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func animateCellsToLeft(isAnimated: Bool, cell: UICollectionViewCell, row: Int, animateDone: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) {
            if isAnimated == false {
                cell.transform = CGAffineTransform(translationX: cell.frame.width / 2, y: 0)
                cell.alpha = 0
                UIView.animate(withDuration: 0.5, delay: 0.05*Double(row), options: [.curveEaseInOut], animations: {
                    cell.transform = CGAffineTransform(translationX: 0, y: 0)
                    cell.alpha = 1
                }) { (done) in
                    animateDone()
                }
            }
        }
    }
    
}
