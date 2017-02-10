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

private let segTitleViewHeight: CGFloat = 35
private let contentTopInst: CGFloat = UIScreen.height  - UITabBar.height
private let segTitleViewY: CGFloat = UIScreen.height  - segTitleViewHeight - UITabBar.height
private let banheight: CGFloat = 200
private let recommandAndHotSectionHeight: CGFloat = UIScreen.height - banheight - UITabBar.height - segTitleViewHeight
private let recommendSectionHeigh: CGFloat = 150
private let hotSectionHeigh: CGFloat = recommandAndHotSectionHeight - recommendSectionHeigh
private let sectionHeaderHeigh: CGFloat = segTitleViewHeight

class FindViewModel {
   lazy var banners: [Banner] = [Banner]()
   lazy var activities: [Activity] = [Activity]()
   lazy var subjecList: [SubjectModel] = [SubjectModel]()
   lazy var findlist: [FindBox] = [FindBox]()
   let bannerHeight: CGFloat = banheight
   let segmenTitleViewHeight: CGFloat = segTitleViewHeight
   let contentTopInset: CGFloat = contentTopInst
   let segmenTitleViewY: CGFloat = segTitleViewY
   let hotSectionHeight: CGFloat = hotSectionHeigh
   let recommendSectionHeight: CGFloat = recommendSectionHeigh
   let sectionHeaderHeight: CGFloat = sectionHeaderHeigh
}

extension FindViewModel {
    func loadbannerAndActivity(finished: @escaping () -> Void) {
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
    
    func loadlistByNew(finish: @escaping () -> Void) {
        loadList(By: .listByNew, finish: finish)
    }
    
    func loadlistByRec(finish:  @escaping () -> Void) {
        loadList(By: .listByRec, finish: finish)
    }
    
    private func loadList(By endpoint: FindRequestPath, finish: @escaping () -> Void) {
        let param = FindListRequestParam()
        let request: Promise<FindList> = RequstManager.requst(Router.endpointWithoutToken(param: param, endPoint: endpoint))
        request.then { data -> Void in
            guard let list = data.list else { return }
            list.forEach { json in
                guard let typeStr = json["type_id"] as? String, let type = DataType(rawValue: typeStr) else {  return }
                switch type {
                case .topic:
                    if let topicJson = json["topic"] as? [String: Any], let model = TopicModel(JSON: topicJson) {
                         let topicModel = FindBox.topic(model)
                        self.findlist.append(topicModel)
                    }
                case .post:
                    if let postJson = json["post"] as? [String: Any], let model = Post(JSON: postJson) {
                        let postModel = FindBox.post(model)
                        self.findlist.append(postModel)
                    }
                }
            }
            finish()
        }.catch { error in
            
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
