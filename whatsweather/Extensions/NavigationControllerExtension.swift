//
//  NavigationControllerExtension.swift
//  birebir-diyet-ios
//
//  Created by tunay alver on 11.07.2019.
//  Copyright © 2019 mobillium. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    //MARK: - NavigationBar Style
    func changeNavigationBarStyle(color: UIColor) {
        if color == .clear {
            self.navigationBar.isTranslucent = true
        }else {
            self.navigationBar.isTranslucent = false
        }
        self.navigationBar.backgroundColor = color
        self.navigationBar.shadowImage = color.as1ptImage()
        self.navigationBar.setBackgroundImage(color.as1ptImage(), for: .default)
    }
    
}
