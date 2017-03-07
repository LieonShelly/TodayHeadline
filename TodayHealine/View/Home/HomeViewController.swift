//
//  HomeViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

private let bannerHeight: CGFloat = 64 + 150
private let titleViewHeight: CGFloat = 44
class HomeViewController: BaseViewController {
    fileprivate lazy var homeVM: HomeViewModel = HomeViewModel()
    fileprivate lazy var tableViewArray: [UITableView] = [UITableView]()
    fileprivate var lastTableViewOffsetY: CGFloat = CGFloat()
    fileprivate lazy var bannerView: CycleView = {
        let bannerView = CycleView.cycleView()
        bannerView.backgroundColor = UIColor.yellow
        bannerView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: bannerHeight)
        return bannerView
    }()

    fileprivate lazy var contentView: PageContentView = { [unowned self] in
        var childVCs = [UIViewController]()
        for _ in 0 ... 5 {
            let recommendVC = RecommendViewController()
            childVCs.append(recommendVC)
            recommendVC.tableView.contentInset = UIEdgeInsets(top: self.titleView.frame.maxY, left: 0, bottom: 0, right: 0)
            recommendVC.tableView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
            /// 让每个view进行一次预加载
            recommendVC.view.frame =  CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
            self.tableViewArray.append(recommendVC.tableView)
        }
        let x: CGFloat = 0
        let y: CGFloat = 0
        let height: CGFloat = UIScreen.height
        let width: CGFloat = UIScreen.width
        let contentView = PageContentView(frame: CGRect(x: x, y: y, width: width, height: height), childVCs: childVCs, parentVC: self)
        return contentView
    }()

    fileprivate lazy var titleView: PageTitleView = { [unowned self] in
        let x: CGFloat = 0
        let y: CGFloat = self.bannerView.frame.maxY
        let height: CGFloat = titleViewHeight
        let width: CGFloat = UIScreen.width
        let titleView = PageTitleView(frame: CGRect(x: x, y: y, width: width, height: height), titles: ["推荐", "热点", "成都", "视屏", "社会", "科技"])
        titleView.normalColor = (0, 0, 0)
        titleView.selectColor = (255, 0, 0)
        titleView.backgroundColor = UIColor.white
        return titleView
    }()

    fileprivate lazy var naviBar: HomeNaviBar = {
        let naivBar = HomeNaviBar.naviBar()
        naivBar.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: 64)
        return naivBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setTapAction()
        loadBanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    deinit {
        for tableView in tableViewArray {
            tableView.removeObserver(self, forKeyPath: "contentOffset")
        }
    }
}
extension HomeViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentOffset", let tableView = object as? UITableView {
            let offsetY = tableView.contentOffset.y
            lastTableViewOffsetY = offsetY
            if offsetY > -bannerHeight - titleViewHeight && offsetY < -(bannerHeight - titleViewHeight - 64) {
                bannerView.frame.origin.y = 0 - bannerHeight - titleViewHeight -  offsetY
                let tatio = -((1 / (-2 * titleViewHeight - 64)) * offsetY - (bannerHeight + titleViewHeight) / (2 * titleViewHeight + 64))
                naviBar.setup(opacity: tatio)
            } else if offsetY >= -(bannerHeight - titleViewHeight - 64) {
                bannerView.frame.origin.y = -(bannerHeight  - 64)
                 naviBar.setup(opacity: 1)
            } else {
                 bannerView.frame.origin.y = 0
                naviBar.setup(opacity: 0)
            }
         titleView.frame.origin.y = bannerView.frame.maxY
        }
    }
}

extension HomeViewController {
    fileprivate  func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(contentView)
        view.addSubview(bannerView)
        view.addSubview(titleView)
        view.addSubview(naviBar)
        
    }
    
    fileprivate func setTapAction() {
        titleView.titleTapAction = { [unowned self ] selectedIndex in
            for tableView in self.tableViewArray {
                tableView.contentOffset = CGPoint(x: 0, y: self.lastTableViewOffsetY)
                let offsetY = self.lastTableViewOffsetY
                if offsetY > -bannerHeight - titleViewHeight && offsetY < -(bannerHeight - titleViewHeight - 64) {
                    tableView.contentOffset = CGPoint(x: 0, y: self.lastTableViewOffsetY)
                } else if offsetY >= -(bannerHeight - titleViewHeight - 64) {
                    tableView.contentOffset = CGPoint(x: 0, y: -(bannerHeight - 64 - titleViewHeight))
                } else {
                    tableView.contentOffset = CGPoint(x: 0, y: -(bannerHeight + titleViewHeight))
                }
            }
            self.contentView.selected(index: selectedIndex)
            
        }
        contentView.tapAction = { [unowned self ]progress, sourceIndex, targetIndx in
            for tableView in self.tableViewArray {
                tableView.contentOffset = CGPoint(x: 0, y: self.lastTableViewOffsetY)
                let offsetY = self.lastTableViewOffsetY
                if offsetY > -bannerHeight - titleViewHeight && offsetY < -(bannerHeight - titleViewHeight - 64) {
                    tableView.contentOffset = CGPoint(x: 0, y: self.lastTableViewOffsetY)
                } else if offsetY >= -(bannerHeight - titleViewHeight - 64) {
                    tableView.contentOffset = CGPoint(x: 0, y: -(bannerHeight - 64 - titleViewHeight))
                } else {
                    tableView.contentOffset = CGPoint(x: 0, y: -(bannerHeight + titleViewHeight))
                }
            }
            self.titleView.setTitle(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndx)
        }
    }
    
    fileprivate  func loadBanner() {
        homeVM.loadBanner { [unowned self] in
            self.bannerView.banners = self.homeVM.banners
        }
    }
    
}
