//
//  DateExtension.swift
//  whatsweather
//
//  Created by tunay alver on 8.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

extension Date {
    
    enum Format: String {
        case readableTime               = "HH:mm"
    }
    
    static func from(_ date: String, _ format: Date.Format) -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = format.rawValue
        
        return dateformatter.date(from: date)
    }
    
    func to(_ format: Date.Format) -> String {
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale(identifier: "tr_TR")
        
        dateformatter.dateFormat = format.rawValue
        return dateformatter.string(from: self)
    }
    
    func getComponents() -> DateComponents {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return components
    }
    
}
