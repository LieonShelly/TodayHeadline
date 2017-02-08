//
//  RecHotTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class RecHotTableViewCell: UITableViewCell {
    internal var finVM: FindViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.recTableViewCell)
        tableView.register(R.nib.hotTableViewCell)
        tableView.register(R.nib.labelAndBottomTableViewHeaderView(), forHeaderFooterViewReuseIdentifier: R.nib.labelAndBottomTableViewHeaderView.name)
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
            cell.getModel(data: finVM?.subjecList)
            return cell
        case 1:
            let cell: HotTableViewCell = tableView.dequeueReuseableCell(for: indexPath)
            cell.getModel(data: finVM?.activities)
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
            return (finVM?.recommendSectionHeight ?? 0) - ((finVM?.segmenTitleViewHeight) ?? 0)
        case 1:
            return tableView.bounds.height - ((finVM?.recommendSectionHeight) ?? 0) - ((finVM?.segmenTitleViewHeight) ?? 0)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: LabelAndBottomTableViewHeaderView = tableView.dequeueReuseableHeaderFooter(for: section)
        switch section {
        case 0:
            headerView.tagLabel.text = "推荐小组"
        case 1:
            headerView.tagLabel.text = "热门活动"
        default:
            break
        }
        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return finVM?.segmenTitleViewHeight ?? 0
    }
}

extension RecHotTableViewCell: ViewNameReusable {}
