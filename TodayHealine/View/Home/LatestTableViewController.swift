//
//  LatestTableViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class LatestTableViewController: HomeBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
    }
    
    deinit {
        removeObserver()
    }
}

extension LatestTableViewController: HomeTableViewContentOffsetYChanged {
    var table: UITableView {
        return self.tableView
    }
}
