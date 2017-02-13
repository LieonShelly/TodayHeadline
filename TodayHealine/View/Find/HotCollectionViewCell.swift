//
//  HotCollectionViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HotCollectionViewCell: UICollectionViewCell, OneLabelProtocol, OneImageOneLabelProtocol, View {
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sublabel: UILabel!
}

extension HotCollectionViewCell: ViewNameReusable {}
