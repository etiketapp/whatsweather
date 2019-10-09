//
//  City.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class City: Codable {
    
    var id: Int!
    var name: String!
    var coord: Location!
    var country: String!
    var timezone: Int!
    var sunrise: Int!
    var sunset: Int!
    
    init() {    }
    
    init(name: String, coord: Location) {
        self.name = name
        self.coord = coord
    }
    
}
