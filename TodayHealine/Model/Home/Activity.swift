//
//  Activity.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/6.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import ObjectMapper

class ActivityGroup: Model {
    var activityList: [Activity]?
    
    override func mapping(map: Map) {
        activityList <- map["activity_list"]
    }
}

class Activity: Model {
    var icon: String?
    var id: String?
    var title: String?
    var userCount: Int = 0
    
    override func mapping(map: Map) {
        icon <- map["icon"]
        id <- map["id"]
        title <- map["title"]
        userCount <- (map["users"], IntStringTransform())
    }
}
