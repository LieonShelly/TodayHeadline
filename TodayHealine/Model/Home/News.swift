//
//  News.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/17.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

/**
 "read_count":10679251,
 "ban_comment":0,
 "abstract":"习近平访问瑞士 出席年会 为世界经济贡献中国智慧",
 "image_list":Array[0],
 "like_count":383,
 "has_video":false,
 "article_type":1,
 "tag":"news_world",
 "has_m3u8_video":0,
 "keywords":"开幕式,习近平,瑞士,世界经济论坛",
 "rid":"201701172023051720171970021099A1",
 "label":"置顶",
 "show_portrait_article":false,
 "user_verified":0,
 "aggr_type":1,
 "cell_type":0,
 "article_sub_type":0,
 "bury_count":123,
 "title":"习近平出席世界经济论坛2017年年会开幕式并发表主旨演讲",
 "ignore_web_transform":1,
 "source_icon_style":2,
 "tip":0,
 "hot":0,
 "share_url":"http://toutiao.com/group/6374658936930304514/?iid=7429513344&app=news_article",
 "has_mp4_video":0,
 "source":"专题",
 "comment_count":838,
 "article_url":"http://a3.pstatp.com/subject2/6374658936930304514/?version=0",
 "filter_words":Array[0],
 "stick_label":"置顶",
 "publish_time":1484653073,
 "action_list":Array[4],
 "has_image":false,
 "cell_layout_style":1,
 "tag_id":6374658936930305000,
 "video_style":0,
 "verified_content":"",
 "display_url":"http://a3.pstatp.com/subject2/6374658936930304514/?version=0",
 "is_stick":true,
 "large_image_list":Array[0],
 "item_id":6374658938628998000,
 "is_subject":true,
 "stick_style":1,
 "show_portrait":false,
 "repin_count":77014,
 "cell_flag":11,
 "source_open_url":"sslocal://search?from=feed_source&keyword=%E4%B8%93%E9%A2%98",
 "level":0,
 "source_avatar":"http://p1.pstatp.com/medium/dd30000ce5593c8c44a",
 "digg_count":383,
 "behot_time":1484655785,
 "article_alt_url":"http://toutiao.com/group/article/6374658936930304514/",
 "cursor":1484655785999,
 "url":"http://a3.pstatp.com/subject2/6374658936930304514/?version=0",
 "preload_web":1,
 "user_repin":0,
 "label_style":1,
 "item_version":0,
 "group_id":6374658936930305000,
 "middle_image":Object{...}
 */
class News: Model {
    var title: String?
    var label: String?
    var source: String?
    var commentCount: Int?
    var publishTime: Double?
    
    override func mapping(map: Map) {
        title <- map["title"]
        label <- map["stick_label"]
        source <- map["source"]
        commentCount <- map["comment_count"]
        publishTime <- map["publish_time"]
    }
}
