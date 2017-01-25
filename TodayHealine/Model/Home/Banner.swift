//
//  Banner.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

/*
 ["photo_height": 432, "parent_id": 1, "sub_title": , "topic_type": , "is_show_icon": 0, "type": topic_list, "index": 225, "subject": {
 }, "activity": {
 }, "photo_width": 900, "id": 1448, "photo": http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201701/57101549.jpg?v=1485080985, "extend": 1454,794,1153,2322,12776,224,1114,2047, "title": 刷夜通宵的法宝都在这了, "browser_url": , "topic": {
 }, "post": {
 }]
 **/
class Banner: Model {
    var photo: URL?
    var title: String?
    
    override func mapping(map: Map) {
        photo <- (map["photo"], URLTransform())
        title <- map["title"]
    }
}
