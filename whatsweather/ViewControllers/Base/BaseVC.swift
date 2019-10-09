//
//  BaseVC.swift
//  whatsweather
//
//  Created by tunay alver on 3.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarBackButtonEmpty()
        addAppIconToNavbar()
        view.backgroundColor = .white
    }

}
