//
//  Network.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class RecommenRequstParam: Model {
    var page: Int = 0
    var pageSize: Int = 20
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        page <- (map["page"], IntStringTransform())
        pageSize <- (map["pagesize"], IntStringTransform())
    }
}

class FindRequstParam: Model {
}

enum HomeRequestPath: EndPointProtocol {
    case banner
    case recommendList
    
    var path: String {
        switch self {
        case .banner:
            return "recommend/"
        case .recommendList:
            return "recommend/"
        }
    }
    
    var endPoint: String {
        switch self {
        case .banner:
            return "operationElement?"
        case .recommendList:
            return "index?"
        }
    }
}

enum FindRequestPath: EndPointProtocol {
    case bannerAndActivity
    case listActivity

    var path: String {
        switch self {
        case .bannerAndActivity:
            return "post/index/"
        case .listActivity:
            return "post/index/"
        }
    }
    
    var endPoint: String {
        switch self {
        case .bannerAndActivity:
            return "index"
        case .listActivity:
            return "listByNew"
        }
    }
}
