//
//  HomeBaseTableViewController.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/24.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class HomeBaseTableViewController: UITableViewController {
    private lazy var parentVC: HomeBaseTableViewController = {
      let vc =  self.parent as? HomeBaseTableViewController ?? HomeBaseTableViewController()
        return vc
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension HomeBaseTableViewController {
     override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
