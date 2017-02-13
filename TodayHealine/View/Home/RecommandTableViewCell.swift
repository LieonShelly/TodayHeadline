//
//  RecommandTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

final class RecommandTableViewCell: BaseTableViewCell {
  @IBOutlet  weak var prictureView: UIImageView!
  @IBOutlet  weak var firstButton: UIButton!
  @IBOutlet  weak var secondButton: UIButton!
  @IBOutlet  weak var thirdButton: UIButton!
  @IBOutlet  weak var titleLabel: UILabel!
}

extension RecommandTableViewCell: View, RecommandTableViewCellProtocol { }
