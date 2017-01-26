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
    var appID: String = "com.jzyd.BanTang"
    var appInstallTime: String = "1485197663"
    var appVersions: String = "5.9.7"
    var channelName: String = "appStore"
    var clientID: String = "bt_app_ios"
    var clientSecret: String = "9c1e6634ce1c5098e056628cd66a17a5"
    var osVersions: String = "10.2.1"
    var screenSize: String = "750"
    var trackDeviceInfo: String = "iPhone9,1"
    var trackDeviceUUID: String = "24D7C3B9-5D1A-447A-9873-B662350FAAAC"
    var trackDeviceID: String = "B8288A9B-027C-4AC8-9B43-8AB19F637125"
    var vvvv: String = "25"
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        appID <- map["app_id"]
        appInstallTime <- map["app_installtime"]
        appVersions <- map["app_versions"]
        channelName <- map["channel_name"]
        clientID <- map["client_id"]
        clientSecret <- map["client_secret"]
        osVersions <- map["os_versions"]
        screenSize <- map["screensize"]
        trackDeviceInfo <- map["track_device_info"]
        trackDeviceUUID <- map["track_device_uuid"]
        trackDeviceID <- map["track_deviceid"]
        vvvv <- map["v"]
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

extension Model: CustomDebugStringConvertible {
    public var debugDescription: String {
        var str = "\n"
        let properties = Mirror(reflecting: self).children
        for c in properties {
            if let name = c.label {
                str += name + ": \(c.value)\n"
            }
        }
        return str
    }
}
