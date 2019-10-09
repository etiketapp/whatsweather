//
//  ResponseError.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class ResponseError: Codable {
    
    var cod: String!
    var message: String!
    
    init(cod: String, message: String) {
        self.cod = cod
        self.message = message
    }
    
}
