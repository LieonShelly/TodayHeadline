//
//  HomeViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate lazy var contentView: PageContentView = {
        var childVCs = [UIViewController]()
        let recommendVC = RecommendViewController()
        let gameVC = RecommendViewController()
        let entertainmentVC = RecommendViewController()
        childVCs.append(recommendVC)
        childVCs.append(gameVC)
        childVCs.append(entertainmentVC)
        childVCs.append(RecommendViewController())
        childVCs.append(RecommendViewController())
        childVCs.append(RecommendViewController())
        childVCs.append(RecommendViewController())
        let x: CGFloat = 0
        let y: CGFloat = 64 + 44
        let height: CGFloat = UIScreen.height - 64 - 44 - 44
        let width: CGFloat = UIScreen.width
        let contentView = PageContentView(frame: CGRect(x: x, y: y, width: width, height: height), childVCs: childVCs, parentVC: self)
        
        return contentView
    }()

    fileprivate lazy var titleView: PageTitleView = {
        let x: CGFloat = 0
        let y: CGFloat = 64
        let height: CGFloat = 44
        let width: CGFloat = UIScreen.width
        let titleView = PageTitleView(frame: CGRect(x: x, y: y, width: width, height: height), titles: ["1", "2", "3", "4", "5", "6", "7", "8"])
        
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTapAction()
    }
}

extension HomeViewController {
    fileprivate  func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(titleView)
        view.addSubview(contentView)
    }
    
    fileprivate func setTapAction() {
        titleView.titleTapAction = { [unowned self ] selectedIndex in
            self.contentView.selected(index: selectedIndex)
        }
        
        contentView.tapAction = { [unowned self ]progress, sourceIndex, targetIndx in
            self.titleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndx)
        }
    }
}
