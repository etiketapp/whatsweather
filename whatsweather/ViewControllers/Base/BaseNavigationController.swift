//
//  BaseNavigationController.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.backgroundColor = .white
        navigationBar.tintColor = Colors.navigationTint
        navigationBar.shadowImage = UIImage()
        let backImage = UIImage(named: "ic_nav_back")
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
    }
    
}
