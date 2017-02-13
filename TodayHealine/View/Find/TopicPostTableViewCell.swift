//
//  TopicPostTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/10.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class TopicPostTableViewCell: BaseTableViewCell {
   lazy var bannerView: CycleView! = CycleView.cycleView()
    @IBOutlet weak var sublabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var view: UIView!
    var tapAction: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    @IBAction func buttonTapAction(_ sender: UIButton) {
        print(sender.tag)
        tapAction?(sender.tag)
    }
}

extension TopicPostTableViewCell: OneLabelProtocol, TwoLabelProtocol, OneImageOneLabelProtocol, ButtonActionProtocol, View, OneViewProtocol {}
