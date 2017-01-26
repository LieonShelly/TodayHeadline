//
//  RecomandViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

class RecomandViewModel {
    lazy var recommandDatas: [TopicModel] = [TopicModel]()
}

extension RecomandViewModel {
    func loadData(finished: @escaping () -> Void) {
      let req: Promise<TopicGroup> = RequstManager.requst(Router.endpointWithoutToken(param: RecommenRequstParam(), endPoint: HomeRequestPath.recommendList))
        req.then { (group) -> Void in
            if let datas = group.topicArray {
                self.recommandDatas = datas
                finished()
            }
        }.catch { error in
            print(error)
        }
    }
}

fileprivate class TopicGroup: Model {
    var topicArray: [TopicModel]?
    override func mapping(map: Map) {
        topicArray <- map["topic"]
    }
}
