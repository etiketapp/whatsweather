//
//  Location.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class Location: Codable {
    
    var lat: Double!
    var lon: Double!
    
    init() {    }
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
    
}
