//
//  FindViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit

private let bannerHeight: CGFloat = 200
private let segmenTitleViewHeight: CGFloat = 44
private let contentTopInset: CGFloat = UIScreen.height  - UITabBar.height
private let segmenTitleViewY: CGFloat = UIScreen.height  - segmenTitleViewHeight - UITabBar.height
class FindViewController: BaseViewController {
    fileprivate lazy var finVM: FindViewModel =  FindViewModel()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0.0, y: 64.0, width: UIScreen.width, height: UIScreen.height), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    fileprivate lazy var bannerView: CycleView = {
        let bannerView = CycleView.cycleView()
        bannerView.backgroundColor = UIColor.yellow
        bannerView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.width), height: Int(bannerHeight))
        return bannerView
    }()

    fileprivate lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UITabBar.height))
            contentView.backgroundColor = UIColor.random()
        return contentView
    }()

    fileprivate lazy var segmentContentView: PageContentView = {[unowned self] in
        var childVCs = [UITableViewController]()
        let latestVC = LatestViewController()
        let hotVC = HotViewController()
        let followVC = FollowViewController()
        childVCs.append(latestVC)
        childVCs.append(hotVC)
        childVCs.append(followVC)
        childVCs.forEach({ (vcc) in
            vcc.tableView.contentInset = UIEdgeInsets(top: contentTopInset, left: 0, bottom: 0, right: 0)
        })
        let contentView = PageContentView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height), childVCs: childVCs, parentVC: self)
        contentView.backgroundColor = UIColor.random()
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension FindViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return finVM.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return finVM.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.contentView.backgroundColor = UIColor.random()
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = SegmentView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.width), height: Int(segmenTitleViewHeight)), titles: ["最新", "热门", "关注"])
        return titleView
    }
    
}

extension FindViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return finVM.heightForRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return finVM.heightForHeader(in: section)
    }
}

extension FindViewController {
    fileprivate func setupUI() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    fileprivate func loadData() {
        finVM.loadBanner {
            
        }
    }
}

extension FindViewController {
    override func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        navigationController.setNavigationBarHidden(false, animated: false)
    }
}
