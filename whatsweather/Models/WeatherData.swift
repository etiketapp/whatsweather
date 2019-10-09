//
//  WeatherData.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class WeatherData: Codable {
    
    var dt: Int!
    var main: Main!
    var weather: [Weather]!
    var clouds: Clouds!
    var wind: Wind!
    var sys: Sys!
    var dt_txt: String!
    
    var isSelected: Bool? = false
    
    func dateIt() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateData = dateFormatter.date(from: dt_txt)
        return dateData!
    }
    
}
