//
//  BaseResponseObject.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/17.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseResponseObject<T: Mappable>: Model {
    var data: T?
    override func mapping(map: Map) {
        data <- map["data"]
    }
}

class Model: Mappable {
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
}

class TestResponseObj<T: Mappable>: Model {
    var content: T?
    var code: String?
    
    override func mapping(map: Map) {
        content <- map["content"]
        code <- map["code"]
    }
}

class TestParam: EndPointProtocol {
    var baseURL: String {
        return "http://is.snssdk.com/api/news/feed/v49/?version_code=5.9.4&app_name=news_article&vid=9C031438-FD95-48AB-A043-0AEC587BD0D4&device_id=25295014168&channel=App%20Store&resolution=750*1334&aid=13&ab_version=101967,100770,100743,102063,101786,101988,101848,101827,102168,101533,100845,97143,100729,31210,102123,101558,92441,101295,102165,101000,102111,100961,100755,101710,98040,100825,101405,101310,101799&ab_feature=z1&openudid=3d20c6f2d7de79d11eae5717e72cc830c5beb076&live_sdk_version=1.3.0&idfv=9C031438-FD95-48AB-A043-0AEC587BD0D4&ac=WIFI&os_version=10.2&ssmix=a&device_platform=iphone&iid=7429513344&ab_client=a1,f2,f7,e1&device_type=iPhone%207&idfa=B8288A9B-027C-4AC8-9B43-8AB19F637125&LBS_status=authroize&city=%E6%88%90%E9%83%BD&concern_id=6286225228934679042&count=20&cp=578070DaC0E1Eq1&detail=1&image=1&language=zh-Hans-CN&last_refresh_sub_entrance_interval=1484639773&loc_mode=1&min_behot_time=1484635092&refer=1&strict=0&tt_from=pull"
    }
}
