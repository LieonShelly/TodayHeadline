//
//  RecHotTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class RecHotTableViewCell: UITableViewCell {
    internal var finVM: FindViewModel?
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.recTableViewCell)
        tableView.register(R.nib.hotTableViewCell)
    }
}

extension RecHotTableViewCell: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell: RecTableViewCell = tableView.dequeueReuseableCell(for: indexPath)
            return cell
        case 1:
            let cell: HotTableViewCell = tableView.dequeueReuseableCell(for: indexPath)
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension RecHotTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return finVM?.recommendSectionHeight ?? 0
        case 1:
            return finVM?.hotSectionHeight ?? 0
        default:
            return 0
        }
    }
}

extension RecHotTableViewCell: ViewNameReusable {}
