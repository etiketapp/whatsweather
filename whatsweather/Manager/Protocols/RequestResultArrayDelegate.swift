//
//  RequestResultArrayDelegate.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

protocol RequestResultArrayDelegate: RequestDelegate {
    
    associatedtype ResultObjectType: Codable
    
    func didSuccess(_ result: ResponseArray<ResultObjectType>)
    
}

extension RequestResultArrayDelegate {
    
    func request(success: @escaping RequestManager.ArrayClosure<ResultObjectType>, failure: @escaping RequestManager.ErrorClosure) {
        RequestManager.request(self, success: { (result: ResponseArray<ResultObjectType>) in
            self.didSuccess(result)
            success(result)
        }) { (error) in
            self.didError(error)
            failure(error)
        }
    }
    
    func didSuccess(_ result: ResponseArray<ResultObjectType>) {}
    
}
