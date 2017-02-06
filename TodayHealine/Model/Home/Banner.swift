//
//  Banner.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class Banner: Model, BannerProtocol {
    var photo: URL?
    var title: String?

    override func mapping(map: Map) {
        photo <- (map["photo"], URLTransform())
        title <- map["title"]
    }
    
    func imageURL() -> URL? {
        return self.photo
    }
}

class BannerGroup: Model {
    var banner: [Banner]?
    
    override func mapping(map: Map) {
        banner <- map["banner"]
    }
}
