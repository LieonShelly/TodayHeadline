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

private let segTitleViewHeight: CGFloat = 40
private let contentTopInst: CGFloat = UIScreen.height  - UITabBar.height
private let segTitleViewY: CGFloat = UIScreen.height  - segTitleViewHeight - UITabBar.height
private let banheight: CGFloat = 200
private let recommandAndHotSectionHeight: CGFloat = UIScreen.height - banheight - UITabBar.height - segTitleViewHeight
private let recommendSectionHeigh: CGFloat = 100
private let hotSectionHeigh: CGFloat = recommandAndHotSectionHeight - recommendSectionHeigh
private let sectionHeaderHeigh: CGFloat = segTitleViewHeight

class FindViewModel {
   lazy var banners: [Banner] = [Banner]()
   lazy var activities: [Activity] = [Activity]()
   lazy var subjecList: [SubjectModel] = [SubjectModel]()
   let bannerHeight: CGFloat = banheight
   let segmenTitleViewHeight: CGFloat = segTitleViewHeight
   let contentTopInset: CGFloat = contentTopInst
   let segmenTitleViewY: CGFloat = segTitleViewY
   let hotSectionHeight: CGFloat = hotSectionHeigh
   let recommendSectionHeight: CGFloat = recommendSectionHeigh
   let sectionHeaderHeight: CGFloat = sectionHeaderHeigh
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
        return section == 1 ? 40: 1
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return recommandAndHotSectionHeight
        }
        return 80.0
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        if section == 1 {
            return sectionHeaderHeight
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
