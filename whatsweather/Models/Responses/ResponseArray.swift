//
//  ResponseArray.swift
//  festivalvar
//
//  Created by tunay alver on 13.08.2019.
//  Copyright © 2019 tunay alver. All rights reserved.
//

import Foundation

class ResponseArray<T: Codable>: BaseResponse {
    
    var list: [T]!
    
    enum CodingKeys: String, CodingKey {
        case list
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode([T].self, forKey: .list)
        try super.init(from: decoder)
    }
    
}
