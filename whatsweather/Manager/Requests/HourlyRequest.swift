//
//  HourlyRequest.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

struct HourlyRequest: RequestResultArrayDelegate {
    
    typealias ResultObjectType = WeatherData
    
    var path: String = ""
    var method: HTTPMethod = .get
    var parameters: Parameters?
    var appid = "a9f1591ef5217a0c55b71cb26c179c3e"
    
    init(lat: Double, lon: Double) {
        parameters = [:]
        parameters!["lat"] = lat
        parameters!["lon"] = lon
        parameters!["appid"] = appid
    }
    
}
