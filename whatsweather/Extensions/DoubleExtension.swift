//
//  DoubleExtension.swift
//  whatsweather
//
//  Created by tunay alver on 8.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

extension Double {
    
    //MARK: - Kelvin to celsius
    func toCelsius() -> Int {
        let celsius = self - 273.15
        return Int(celsius)
    }
    
    //MARK: - Fahrenheit to celsius
    func fahrenheitToCelsius() -> Int {
        let celsius = (self - 32) * (5/9)
        return Int(celsius)
    }
    
}
