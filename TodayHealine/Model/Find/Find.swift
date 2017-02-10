//
//  Find.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/10.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class FindList: Model {
    var list: [[String: Any]]?
    
    override func mapping(map: Map) {
        list <- map["list"]
    }
}

class BrandProduct: Model {
    var itemSubtitle: String?
    var productId: String?
    var itemName: String?
    
    override func mapping(map: Map) {
        itemSubtitle <- map["item_subtitle"]
        productId <- map["product_id"]
        itemName <- map["item_name"]
    }
}

class Dynamic: Model {
    var comments: String?
    var iscollect: Bool = false
    var ispraise: Bool = false
    var likes: String?
    var praises: String?
    var views: String?
    
    override func mapping(map: Map) {
        comments <- map["comments"]
        iscollect <- (map["iscollect"], BoolStringTransform())
        ispraise <- (map["ispraise"], BoolStringTransform())
        likes <- map["likes"]
        praises <- map["praises"]
        views <- map["views"]
    }
}

class ReleationActivity: Model {
    var content: String?
    var cover: URL?
    var id: String?
    var isExpired: Bool = false
    var pic: URL?
    var title: String?
    var userList: [User]?
    var users: Int = 0
    
    override func mapping(map: Map) {
        content <- map["content"]
        cover <- (map["cover"], URLTransform())
        id <- map["id"]
        isExpired <- (map["is_expired"], BoolStringTransform())
        pic <- (map["pic"], URLTransform())
        title <- map["title"]
        userList <- map["user_list"]
        users <- (map["users"], IntStringTransform())
    }
}
