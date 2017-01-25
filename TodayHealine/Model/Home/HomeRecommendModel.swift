//
//  HomeRecommendModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class User: Model {
    var userID: String?
    var nickname: String?
    var avatar: String?
    
    override func mapping(map: Map) {
        userID <- map["user_id"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
    }
}

class TopicModel: Model {
    var title: String?
    var picture: URL?
    var praises: String?
    var views: String?
    var user: User?
    
    override func mapping(map: Map) {
        title <- map["title"]
        picture <- (map["pic"], URLTransform())
        praises <- map["praises"]
        views <- map["views"]
        user <- map["user"]
    }
}
