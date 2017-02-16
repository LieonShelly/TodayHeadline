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
import Kingfisher

private let segTitleViewHeight: CGFloat = 35
private let contentTopInst: CGFloat = UIScreen.height  - UITabBar.height
private let segTitleViewY: CGFloat = UIScreen.height  - segTitleViewHeight - UITabBar.height
private let banheight: CGFloat = 200
private let recommandAndHotSectionHeigh: CGFloat = UIScreen.height - banheight - UITabBar.height - segTitleViewHeight
private let recommendSectionHeigh: CGFloat = 150
private let hotSectionHeigh: CGFloat = recommandAndHotSectionHeigh - recommendSectionHeigh
private let sectionHeaderHeigh: CGFloat = segTitleViewHeight
private let userBarHeight: CGFloat = 44
private let titleLabelTop: CGFloat = 8
private let titleLabelHeight: CGFloat = 30
private let titleLabelBottom: CGFloat = 20
private let toolBarAndDividlineHeight: CGFloat = 35

class FindViewModel {
   lazy var banners: [Banner] = [Banner]()
   lazy var activities: [Activity] = [Activity]()
   lazy var subjecList: [SubjectModel] = [SubjectModel]()
   lazy var findlist: [FindBox] = [FindBox]()
   lazy var listCellHeight: [CGFloat] = []
   lazy var listImageViewHeight: [CGFloat] = []
   lazy var cacheListCellHeight: [String: CGFloat] = [:]
   let bannerHeight: CGFloat = banheight
   let segmenTitleViewHeight: CGFloat = segTitleViewHeight
   let contentTopInset: CGFloat = contentTopInst
   let segmenTitleViewY: CGFloat = segTitleViewY
   let hotSectionHeight: CGFloat = hotSectionHeigh
   let recommendSectionHeight: CGFloat = recommendSectionHeigh
   let sectionHeaderHeight: CGFloat = sectionHeaderHeigh
   let recommandAndHotSectionHeight: CGFloat = recommandAndHotSectionHeigh
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
    
    private func caculateImageSize(list: [FindBox], finish: @escaping () -> Void) {
        let group = DispatchGroup()
        list.forEach { box in
            switch box {
            case .topic(let topicModel):
                topicModel.pics?.forEach { imageModel in
                    group.enter()
                    guard  let url = imageModel.url else { return }
                    ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let size = image?.size {
                            imageModel.imageSize = CGSize(width: size.width * 0.5, height: size.height * 0.5)
                            group.leave()
                        }
                    })
                }
            case .post(let postModel):
                postModel.pics?.forEach { imageModel in
                    group.enter()
                    guard  let url = imageModel.url else { return }
                    ImageDownloader.default.downloadImage(with: url, options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let size = image?.size {
                             imageModel.imageSize = CGSize(width: size.width, height: size.height)
                             print(size.width / size.height)
                            group.leave()
                        }
                    })
                }
                break
            }
        }
        group.notify(queue: .main, execute: finish)
    }
    
}

extension FindViewModel {
    func numberOfSections() -> Int {
        return 2
    }
    
    func numberOfRows(in section: Int) -> Int {
        return section == 1 ? findlist.count: 1
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return recommandAndHotSectionHeight
        } 
        return UITableViewAutomaticDimension
    }
    
    func heightForHeader(in section: Int) -> CGFloat {
        if section == 1 {
            return sectionHeaderHeight
        } else {
            return 0.0
        }
    }
    
    private func caculateTopicCellHeight(model: TopicModel) -> CGFloat {
        let userBar: CGFloat = 44
        let  collectionViewHeight: CGFloat = 0
        let titleLabelTop: CGFloat = 10
        let titleLabelBottom: CGFloat = 18
        var titlLabelHeight: CGFloat = 30
        let ns = NSString(string: model.title ?? "")
        let maxSize = CGSize(width: (UIScreen.width - 2 * 10), height: 3000)
        let size = ns.boundingRect(with: maxSize, options: .init(rawValue: 0), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil).size
        titlLabelHeight = size.height
        let toolBar: CGFloat = 30
        let dividline: CGFloat = 5
        return userBar + collectionViewHeight + titlLabelHeight + titleLabelTop + titleLabelBottom + toolBar + dividline
    }
    
    private func caculatePostCellHeight(model: Post) -> CGFloat {
        let userBar: CGFloat = 44
        // (UIScreen.width - 2 * 10) * 0.75
        let  collectionViewHeight: CGFloat = 0
        let titleLabelTop: CGFloat = 10
        let titleLabelBottom: CGFloat = 18
        var titlLabelHeight: CGFloat = 30
        let ns = NSString(string: model.content ?? "")
        let maxSize = CGSize(width: (UIScreen.width - 2 * 10), height: 3000)
        let size = ns.boundingRect(with: maxSize, options: .init(rawValue: 0), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil).size
        titlLabelHeight = size.height
        let toolBar: CGFloat = 30
        let dividline: CGFloat = 5
        return userBar + collectionViewHeight + titlLabelHeight + titleLabelTop + titleLabelBottom + toolBar + dividline
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
