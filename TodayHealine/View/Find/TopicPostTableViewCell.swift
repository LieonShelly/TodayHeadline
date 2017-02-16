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
   
    @IBOutlet weak var imageViewHeightCons: NSLayoutConstraint!
    
    @IBOutlet weak var dividline: UIView!
    var tapAction: ((Int) -> Void)?
    var rowheight: CGFloat = 0.0
    override func awakeFromNib() {
        super.awakeFromNib()
        view.addSubview(bannerView)
        bannerView.closeBanner()
        bannerView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    func configImageView(height: CGFloat) {
        imageViewHeightCons.constant = height
        bannerView.reloadData()
    }
    
    @IBAction func buttonTapAction(_ sender: UIButton) {
        print(sender.tag)
        tapAction?(sender.tag)
    }
    
}

extension TopicPostTableViewCell: OneLabelProtocol, TwoLabelProtocol, OneImageOneLabelProtocol, ButtonActionProtocol, View {}
