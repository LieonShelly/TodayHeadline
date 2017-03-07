//
//  RecommendViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import LRefresh

class RecommendViewController: BaseTableViewController {
    fileprivate lazy var recommandVM: RecomandViewModel =  RecomandViewModel()
    fileprivate lazy var refresh: LRefreshControl = {
        let refresh = LRefreshControl()
        refresh.needToShine(text: "我要操你")
        return refresh
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.addSubview(refresh)
        refresh.refreshHandler = {
            self.loadData()
        }
  }
}

extension RecommendViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recommandVM.recommandDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RecommandTableViewCell = tableView.dequeueReuseableCell(for: indexPath)
        cell.getModel(data: recommandVM.recommandDatas[indexPath.item])
        return cell
    }
}

extension RecommendViewController {
    fileprivate func setupUI() {
        tableView.rowHeight = 316
        tableView.separatorStyle = .none
        tableView.register(R.nib.recommandTableViewCell)
        
    }
    
    fileprivate func loadData() {
        recommandVM.loadData {
          self.tableView.reloadData()
            self.refresh.endRefreshing()
        }
    }
}
