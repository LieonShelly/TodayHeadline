//
//  RecTableViewCell.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/8.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit
import ObjectMapper

class RecTableViewCell: BaseTableViewCell, OneCollectionViewProtocol, View {
    var models: [Mappable]? {
        didSet {
            collectionView.reloadData()
        }
    }
    var tapAction: ((Int) -> Void)? = {cell in}
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
         guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return  }
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(R.nib.recomendCollectionViewCell)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return  }
        layout.itemSize = CGSize(width: (collectionView.bounds.width - 10 * 4) / 3.5, height: (collectionView.bounds.height - 10))
    }
}

extension RecTableViewCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecomendCollectionViewCell = collectionView.dequeueReuseableCell(for: indexPath)
        cell.getModel(data: models?[indexPath.row])
        return cell
    }
}

extension RecTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapAction?(indexPath.item)
    }
}
