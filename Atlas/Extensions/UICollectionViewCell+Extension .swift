//
//  UICollectionViewCell+Extension .swift
//  Atlas
//
//  Created by Franklin Byaruhanga on 03/02/2023.
//

import UIKit

extension UICollectionViewCell {
    static var nibName: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReusableView {}
