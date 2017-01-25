//
//  CycleCollectionViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class CycleCollectionViewCell: UICollectionViewCell {
  @IBOutlet  weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

extension CycleCollectionViewCell: CycleCollectionViewCellProtocol, View { }
