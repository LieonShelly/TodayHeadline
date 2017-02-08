//
//  FindViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/26.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import PromiseKit

class FindViewController: BaseViewController {
    fileprivate lazy var finVM: FindViewModel =  FindViewModel()
    fileprivate lazy var tableView: UITableView = {[unowned self] in
        let tableView = UITableView(frame: CGRect(x: 0.0, y: 0, width: UIScreen.width, height: UIScreen.height), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableHeaderView = self.bannerView
        return tableView
    }()

    fileprivate lazy var bannerView: CycleView = {
        let bannerView = CycleView.cycleView()
        bannerView.backgroundColor = UIColor.yellow
        bannerView.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.width), height: Int(self.finVM.bannerHeight))
        return bannerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
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
        switch indexPath.section {
        case 0:
            let cell: RecHotTableViewCell = tableView.dequeueReuseableCell(for: indexPath)
            cell.finVM = finVM
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.backgroundColor = UIColor.random()
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = SegmentView(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.width), height: Int(finVM.segmenTitleViewHeight)), titles: ["最新", "热门", "关注"])
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
        automaticallyAdjustsScrollViewInsets = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(R.nib.recHotTableViewCell)
    }
    
    fileprivate func loadData() {
        finVM.load { [unowned self] in
            self.bannerView.banners = self.finVM.banners
            self.tableView.reloadData()
        }
    }
}

extension FindViewController {
    
}
