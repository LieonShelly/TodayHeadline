//
//  FindViewModel.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit
import ObjectMapper

class FindViewModel {
   lazy var banners: [Banner] = [Banner]()
   lazy var activities: [Activity] = [Activity]()
   lazy var subjecList: [SubjectModel] = [SubjectModel]()
    
}

extension FindViewModel {
    func loadBanner(finished: @escaping () -> Void) {
        let param = FindRequstParam()
        let req: Promise<FindActiviy> = RequstManager.requst(Router.endpointWithoutToken(param: param, endPoint: FindRequestPath.bannerAndActivity))
        req.then {[unowned self] data    -> Void in
            self.banners = data.banners ?? [Banner]()
            self.activities = data.activities ?? [Activity]()
            self.subjecList = data.subjecList ?? [SubjectModel]()
            finished()
        }.catch { error in
            print(error)
        }
    }
}

extension FindViewModel {
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        return section == 1 ? 40: 4
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        if section == 1 {
            return 40.0
        } else {
            return 0.0
        }
    }
}

fileprivate class FindActiviy: Model {
    var banners: [Banner]?
    var activities: [Activity]?
    var subjecList: [SubjectModel]?
    
    fileprivate override func mapping(map: Map) {
        banners <- map["banner"]
        activities <- map["activity_list"]
        subjecList <- map["subject_list"]
    }
}
