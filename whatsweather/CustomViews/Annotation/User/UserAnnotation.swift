//
//  UserAnnotation.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import MapKit

class UserAnnotation: MKPointAnnotation {
    
    var location: Location!
    var image = UIImage(named: "ic_pin_user_circle")
    
}
