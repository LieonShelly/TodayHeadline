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

extension ViewNameReusable where Self: UIView {
    static var reuseIndentifier: String {
        return String(describing: self)
    }
}

extension View where Self: StickTopTableViewCell {
    func getModel<M>(data: M) {
         guard let model = data as? News else { return  }
        titleLabel.text = model.title
        tagLabel.text = model.label
        commentLabel.text = "\(model.commentCount)评论"
        sourceLabel.text = model.source
        timeLabel.text = "\(model.publishTime)"
    }
}
extension View where Self: CycleCollectionViewCell {
    func getModel<M>(data: M) {
        guard let model = data as? Banner else { return  }
        imageView.kf.setImage(with: model.photo)
    }
}
