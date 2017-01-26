//
//  Router.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

enum Router {
    case endpointWithoutToken(param: Mappable?, endPoint: EndPointProtocol)
    var method: HTTPMethod {
        return .post
    }
    var param: Mappable? {
        switch self {
        case .endpointWithoutToken(param: let param, endPoint: _):
            return param
        }
    }
    
    var URLString: String {
        switch self {
        case .endpointWithoutToken(param: _, endPoint: let path):
            return path.URL()
        }
    }
}
