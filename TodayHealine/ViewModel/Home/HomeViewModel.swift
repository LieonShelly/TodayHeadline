//
//  HomeViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper
import PromiseKit

class HomeViewModel {
    lazy var banners: [Banner] = [Banner]()
    
}

extension HomeViewModel {
    func loadBanner(finished: @escaping (Void) -> Void) {
        let req: Promise<BannerGroup> = RequstManager.requst(Router.endpointWithoutToken(param: RecommenRequstParam(), endPoint: HomeRequestPath.banner))
        req.then { group -> Void in
            if let banners = group.banner {
                self.banners = banners
                finished()
            }
        }.catch { erro in
            print(erro)
        }
    }
}

fileprivate class BannerGroup: Model {
    var banner: [Banner]?
    fileprivate  override func mapping(map: Map) {
        banner <- map["banner"]
    }
}
