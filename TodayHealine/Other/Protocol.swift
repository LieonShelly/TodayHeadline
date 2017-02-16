//
//  Protocol.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/18.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import Kingfisher
import ObjectMapper

protocol BannerViewProtocol {
    weak var collection: UICollectionView! {get set}
    weak var pageControl: UIPageControl! {get set}
}
protocol OneViewProtocol {
    weak var view: UIView! {get set}
}

protocol ButtonActionProtocol {
    var tapAction:((_ buttonTag: Int) -> Void)? {get set}
}

protocol OneLabelProtocol {
    weak var sublabel: UILabel! {get set}
}

protocol TwoLabelProtocol {
    weak var firstLabel: UILabel! {get set}
    weak var secondLabel: UILabel! {get set}
}

protocol OneImageOneLabelProtocol {
    weak var titleLabel: UILabel! {get set}
    weak var iconView: UIImageView! {get set}
}

protocol OneCollectionViewProtocol {
    var models: [Mappable]? {get set}
    var tapAction:((_ tapIndex: Int) -> Void)? {get set}
}

protocol ViewNameReusable: class { }

protocol View: class {
    func getModel<M>(data: M)
}

protocol StickTopTableViewCellProtocol {
    
    weak var titleLabel: UILabel! {get set}
    weak var tagLabel: UILabel! {get set}
    weak var commentLabel: UILabel! {get set}
    weak var sourceLabel: UILabel! {get set}
}

protocol CycleCollectionViewCellProtocol {
     weak var imageView: UIImageView! {get set}
}

protocol RecommandTableViewCellProtocol {
    weak var prictureView: UIImageView! {get set}
    weak var firstButton: UIButton! {get set}
    weak var secondButton: UIButton! {get set}
    weak var thirdButton: UIButton! {get set}
    weak var titleLabel: UILabel! {get set}
}

protocol BannerProtocol {
    func imageURL() -> URL?
}

protocol EndPointProtocol {
    var baseURL: String { get }
    var path: String { get }
    var endPoint: String { get }
    func URL() -> String
}

extension EndPointProtocol {
    var baseURL: String {
        return "http://open3.bantangapp.com/"
    }
    func URL() -> String {
        return baseURL + path + endPoint
    }
}

extension ViewNameReusable where Self: UIView {
    static var reuseIndentifier: String {
        return String(describing: self)
    }
}

extension View where Self: CycleCollectionViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? BannerProtocol else { return  }
        imageView.kf.setImage(with: model.imageURL())
    }
}
extension View where Self: RecommandTableViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? TopicModel else { return  }
        prictureView.kf.setImage(with: model.picture)
        titleLabel.text = model.title
        firstButton.setTitle(model.user?.nickname, for: .normal)
        secondButton.setTitle(model.views, for: .normal)
        thirdButton.setTitle(model.praises, for: .normal)
    }
}

extension View where Self: HotTableViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? [Activity] else { return  }
        models = model
    }
}

extension View where Self: RecTableViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? [SubjectModel] else { return  }
        models = model
    }
}

extension View where Self: OneImageOneLabelProtocol {
    func getModel<M>(data: M) {
        guard let model = data as? SubjectModel else { return  }
        iconView.kf.setImage(with: model.photo)
        titleLabel.text = model.title
    }
}
extension View where Self: HotCollectionViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? Activity else { return  }
        iconView.kf.setImage(with: model.icon)
        titleLabel.text = model.title
        sublabel.text = "\(model.userCount)人参与"
    }
}

extension View where Self: TopicPostTableViewCell {
     func getModel<M>(data: M) {
         guard let model = data as? FindBox else { return  }
        switch model {
        case .topic(let topicModel):
            iconView.kf.setImage(with: topicModel.user?.avatar)
            titleLabel.text = topicModel.user?.nickname
            sublabel.text = topicModel.datestr
            firstLabel.text = topicModel.title
            guard let countStr = topicModel.views else { return }
            secondLabel.text = "\(countStr)浏览"
            bannerView.banners = topicModel.pics
            configImageView(height: (UIScreen.width - 2 * 10) * 0.5)
            break
        case .post(let postModel):
            iconView.kf.setImage(with: postModel.user?.avatar)
            titleLabel.text = postModel.user?.nickname
            sublabel.text = postModel.datestr
            firstLabel.text = postModel.content
            guard let countStr = postModel.dynamic?.views else { return }
            secondLabel.text = "\(countStr)浏览"
            bannerView.banners = postModel.pics
            configImageView(height: (UIScreen.width - 2 * 10) * 0.75 )
            break
        }
        
    }
}
