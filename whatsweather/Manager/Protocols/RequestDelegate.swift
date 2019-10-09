//
//  RequestDelegate.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

protocol RequestDelegate {
    
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get set}
    
    func didError( _ error: ResponseError)
    
}

extension RequestDelegate {
    
    func didError(_ error: ResponseError) {}
    
}
