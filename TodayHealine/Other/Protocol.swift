//
//  Protocol.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/18.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import Kingfisher

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

extension ViewNameReusable where Self: UIView {
    static var reuseIndentifier: String {
        return String(describing: self)
    }
}

extension View where Self: CycleCollectionViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? Banner else { return  }
        imageView.kf.setImage(with: model.photo)
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
