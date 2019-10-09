//
//  RequestManager.swift
//  whatsweather
//
//  Created by tunay alver on 7.10.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Alamofire

class RequestManager {
    
    typealias ErrorClosure = ((ResponseError) -> Void)
    typealias ArrayClosure<T: Codable> = ((ResponseArray<T>) -> Void)
    
    static let errorCodeConnection = "error.connection"
    static let errorCodeLocal = "error.local"
    static let errorCodeUnknown = "error.unknown"
    
    static var apiUrl: String {
        get {
            return "https://api.openweathermap.org/data/2.5/forecast"
        }
    }
    
    private static func createRequest(_ request: RequestDelegate) -> DataRequest {
        print("\n\nRequest Path: \(request.path)")
        print("Request Method: \(request.method.rawValue)")
        print("Request Parameters:")
        print(request.parameters ?? "nil")
        
        let request  = Alamofire.request(apiUrl+request.path, method: request.method, parameters: request.parameters, encoding: URLEncoding.default, headers: nil)
        
        request.validate()
        request.responseData { (response) in
            if let value = response.result.value {
                if let json = String(data: value, encoding: .utf8) {
                    print("Response JSON: \n\(json)")
                }
            }
        }
        return request
    }
    
    static func request<T: Codable>(_ request: RequestDelegate, success: @escaping ArrayClosure<T>, failure: @escaping ErrorClosure) {
        let request = createRequest(request)
        request.responseData { (response) in
            switch response.result {
            case .success:
                success(ResponseArray<T>.decode(response.result.value!)!)
            case .failure:
                handleFailure(response: response, failure: failure)
            }
        }
    }
    
    //MARK: - Handle failure
    private static func handleFailure(response: DataResponse<Data>, failure: @escaping ErrorClosure) {
        if let data = response.data, let serviceError = ResponseError.decode(data) {
            if let json = String(data: data, encoding: .utf8) {
                print("Response JSON: \(json)")
            }
            handleError(statusCode: response.response?.statusCode, localError: nil, serviceError: serviceError, failure: failure)
        } else if let error = response.result.error {
            handleError(statusCode: nil, localError: error, serviceError: nil, failure: failure)
        } else {
            handleError(statusCode: nil, localError: nil, serviceError: nil, failure: failure)
        }
    }
    
    private static func handleError(statusCode: Int?, localError: Error?, serviceError: ResponseError?, failure: @escaping ErrorClosure) {
        if let error = serviceError {
            failure(error)
        } else if let error = localError as? URLError, error.code == .notConnectedToInternet {
            failure(ResponseError(cod: errorCodeConnection, message: error.localizedDescription))
        } else if let error = localError {
            failure(ResponseError(cod: errorCodeLocal, message: error.localizedDescription))
        } else {
            failure(ResponseError(cod: errorCodeUnknown, message: "Unknow Error"))
        }
    }
    
}

