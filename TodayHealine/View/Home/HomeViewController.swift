//
//  HomeViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    var titleViewY: CGFloat = 64 + 80
    fileprivate lazy var contentView: PageContentView = { [unowned self] in
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
        let y: CGFloat = self.titleView.frame.maxY
        let height: CGFloat = UIScreen.height - 64 - 44 - 44
        let width: CGFloat = UIScreen.width
        let contentView = PageContentView(frame: CGRect(x: x, y: y, width: width, height: height), childVCs: childVCs, parentVC: self)
        return contentView
    }()

    fileprivate lazy var titleView: PageTitleView = { [unowned self] in
        let x: CGFloat = 0
        let y: CGFloat = self.titleViewY
        let height: CGFloat = 44
        let width: CGFloat = UIScreen.width
        let titleView = PageTitleView(frame: CGRect(x: x, y: y, width: width, height: height), titles: ["推荐", "热点", "成都", "视屏", "社会", "科技", "火山直播"])
        titleView.normalColor = (0, 0, 0)
        titleView.selectColor = (255, 0, 0)
        titleView.backgroundColor = UIColor.colorFromHex(0xf5f5f5)
        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTapAction()
        addNotification()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
extension HomeViewController {
    
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
    
    fileprivate  func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.contentOffsetYChanged(noti:)), name: NSNotification.Name.init(Constant.NotificationName.HomeTableViewContOffsetYChanged), object: nil)
    }
    
    @objc private func contentOffsetYChanged(noti: Notification) {
        guard let userInfo = noti.userInfo as? [String: CGFloat], let contentOffsetY = userInfo["contentOffsetY"] else { return }
        print(contentOffsetY)
        if contentOffsetY > 0 {
            if  contentOffsetY < 64 + 80 - 64 {
                titleView.frame.origin.y = CGFloat(64) + CGFloat (80) - contentOffsetY
            } else {
                titleView.frame.origin.y = CGFloat(64)
            }
           contentView.frame.origin.y =  titleView.frame.maxY
        } else {
             titleView.frame.origin.y = 64 + 80
            contentView.frame.origin.y =  titleView.frame.maxY
        }
    }
}
