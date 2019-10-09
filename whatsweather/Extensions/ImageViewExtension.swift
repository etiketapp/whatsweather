//
//  ImageViewExtension.swift
//  festivalvar
//
//  Created by tunay alver on 17.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageUrl(imageUrl: String) {
        if let url = URL(string: ((imageUrl))) {
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url)
        }
    }
    
}

