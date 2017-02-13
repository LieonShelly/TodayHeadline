//
//  BaseTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

extension BaseTableViewCell: ViewNameReusable {}
