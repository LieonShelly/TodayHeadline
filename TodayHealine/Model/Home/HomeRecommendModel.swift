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
    var articleTopicCount: String?
    var isOfficial: Bool = false
    var postCount: String?
    
    override func mapping(map: Map) {
        userID <- map["user_id"]
        nickname <- map["nickname"]
        avatar <- map["avatar"]
        articleTopicCount <- map["article_topic_count"]
         isOfficial <- (map["is_official"], BoolStringTransform())
         postCount <- map["post_count"]
    }
}
class ImageModel: Model {
    var url: URL?
    var width: CGFloat = 0.0
    var height: CGFloat = 0.0
    
    override func mapping(map: Map) {
        url <- (map["url"], URLTransform())
    }
    
}
class TopicModel: Model {
    var comments: Int = 0
    var createTimeStr: String?
    var dateline: String?
    var datestr: String?
    var id: String?
    var isRecommend: Bool = false
    var isShowLike: Bool = false
    var islike: Bool = false
    var ispraise: Bool = false
    var items: String?
    var likes: String?
    var pics: [ImageModel]?
    var relationActivity: String?
    var sharePic: URL?
    var shareUrl: URL?
    var type: String?
    var typeId: String?
    var updateTime: String?
    var title: String?
    var picture: URL?
    var praises: String?
    var views: String?
    var user: User?
    
    override func mapping(map: Map) {
        comments <- map["comments"]
        createTimeStr <- map["create_time_str"]
        dateline <- map["dateline"]
        datestr <- map["datestr"]
        id <- map["id"]
        isRecommend <- (map["is_recommend"], BoolStringTransform())
        isShowLike <- (map["is_show_like"], BoolStringTransform())
        islike <- map["islike"]
        ispraise <- map["ispraise"]
        items <- map["items"]
        likes <- map["likes"]
        relationActivity <- map["relation_activity"]
        sharePic <- (map["share_pic"], URLTransform())
        shareUrl <- (map["share_url"], URLTransform())
        type <- map["type"]
        typeId <- map["type_id"]
        updateTime <- map["update_time"]
        user <- map["user"]
        title <- map["title"]
        picture <- (map["pic"], URLTransform())
        praises <- map["praises"]
        views <- map["views"]
        user <- map["user"]
    }
}
