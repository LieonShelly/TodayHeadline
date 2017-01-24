//
//  HomeHeaderView.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {

    fileprivate lazy var bannerView: UIView = {
       let bannerView = UIView()
        bannerView.backgroundColor = UIColor.red
        return bannerView
    }()

    fileprivate lazy var titleView: PageTitleView = {
        let tittleView = PageTitleView()
        tittleView.backgroundColor = UIColor.blue
        return tittleView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bannerView)
        addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(40)
        }
        bannerView.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(titleView.snp.top)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
