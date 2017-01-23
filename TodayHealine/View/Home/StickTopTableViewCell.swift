//
//  StickTopTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/18.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//  置顶

import UIKit

class StickTopTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
}

extension StickTopTableViewCell: StickTopTableViewCellProtocol { }
