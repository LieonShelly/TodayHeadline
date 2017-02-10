//
//  Post.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/10.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class Post: Model {
    var brandProduct: [BrandProduct]?
    var comments:[Any]?
    var content: String?
    var datestr: String?
    var dynamic: Dynamic?
    var id: String?
    var isRecommend: Bool = false
    var middlePicRrl: URL?
    var pics: [ImageModel]?
    var postType: String?
    var relationActivity: ReleationActivity?
    var shareUrl: URL?
    var user: User?
    
    override func mapping(map: Map) {
        brandProduct <- map["brand_product"]
        comments <- map["comments"]
        content <- map["content"]
        datestr <- map["datestr"]
        dynamic <- map["dynamic"]
        id <- map["id"]
        isRecommend <- (map["is_recommend"], BoolStringTransform())
        middlePicRrl <- (map["middle_pic_url"], URLTransform())
        content <- map["content"]
        pics <- map["pics"]
        postType <- map["post_type"]
        relationActivity <- map["relation_activity"]
        shareUrl <- map["share_url"]
        user <- map["user"]
    }
}
