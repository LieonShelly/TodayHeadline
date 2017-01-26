//
//  FindViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit

private let bannerHeight = 200
class FindViewController: BaseViewController {
    fileprivate lazy var finVM: FindViewModel =  FindViewModel()
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style: .plain)
        return tableView
    }()
    fileprivate lazy var bannerView: CycleView = {
        let bannerView = CycleView.cycleView()
        bannerView.backgroundColor = UIColor.yellow
        bannerView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.width), height: bannerHeight)
        return bannerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.tableHeaderView = bannerView
        loadData()
    }
}
/*
 */

extension FindViewController {
    fileprivate func loadData() {
        finVM.loadBanner {
            
        }
    }
}
