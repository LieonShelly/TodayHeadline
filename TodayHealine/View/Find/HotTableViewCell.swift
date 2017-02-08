//
//  HotTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class HotTableViewCell: BaseTableViewCell, OneCollectionViewProtocol, View {
    var models: [Mappable]? {
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var divierLine: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(collectionView.bounds.height)
        collectionView.backgroundColor = divierLine.backgroundColor
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return  }
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(R.nib.hotCollectionViewCell)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return  }
        layout.itemSize = CGSize(width: (collectionView.bounds.width - 1 * 3) * 0.5, height: (collectionView.bounds.height - 1 * 3) * 0.5)
    }
}

extension HotTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HotCollectionViewCell = collectionView.dequeueReuseableCell(for: indexPath)
        cell.getModel(data: models?[indexPath.item])
        return cell
    }
}
