//
//  Subject.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/6.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import ObjectMapper

class SubjectGroup: Model {
    var subjectList: [SubjectModel]?

    override func mapping(map: Map) {
        subjectList <- map["subject_list"]
    }
}

class SubjectModel: Model {
    var activity: Activity?
    var browserUrl: URL?
    var extend: String?
    var id: String?
    var index: Int = 0
    var isShowIcon: Bool = false
    var parentID: String?
    var photo: URL?
    var photoWidth: Int?
    var photoHeight: Int?
    var post: String?
    var subTitle: String?
    var subject: String?
    var title: String?
    var topic: String?
    var topicType: String?
    var type: String?
    
    override func mapping(map: Map) {
        activity <- map["activity"]
        browserUrl <- (map["browser_url"], URLTransform())
        extend <- map["extend"]
        id <- map["id"]
        index <- map["index"]
        isShowIcon <- (map["is_show_icon"], BoolStringTransform())
        parentID <- map["parent_id"]
        photo <- (map["photo"], URLTransform())
        photoWidth <- (map["photo_width"], IntStringTransform())
        photoHeight <- (map["photo_height"], IntStringTransform())
        post <- map["post"]
        title <- map["title"]
        subTitle <- map["sub_title"]
        subject <- map["subject"]
        title <- map["title"]
        topic <- map["topic"]
        topicType <- map["cover"]
        type <- map["type"]
    }
}

class Subject: Model {
    var content: String?
    var cover: String?
    var id: String?
    var pic: URL?
    var title: String?
    var userList: String?
    var userCount: Int = 0
    
    override func mapping(map: Map) {
        content <- map["content"]
        cover <- map["cover"]
        id <- map["id"]
        pic <- (map["pic"], URLTransform())
        title <- map["title"]
        userList <- map["user_list"]
        userCount <- (map["users"], IntStringTransform())
    }
    
}
