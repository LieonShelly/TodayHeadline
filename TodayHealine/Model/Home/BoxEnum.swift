//
//  BoxEnum.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/22.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import Foundation
import ObjectMapper

enum DataType: String {
    case topic = "1"
    case post = "4"
}

enum FindBox {
    case topic(TopicModel)
    case post(Post)
}
