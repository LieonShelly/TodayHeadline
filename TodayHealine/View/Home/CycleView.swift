//
//  CycleView.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/25.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

class CycleView: UIView {
    var banners: [BannerProtocol]? {
        didSet {
            removeTimer()
            addTimer()
            collectionView.reloadData()
            pageControl.numberOfPages = banners?.count ?? 0
            let indexPath = IndexPath(item: (banners?.count ?? 0) * 100, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        }
    }
    var tapAction: ((_ index: Int) -> Void)?
    @IBOutlet weak fileprivate var collectionView: UICollectionView!
    @IBOutlet weak fileprivate var pageControl: UIPageControl!
    fileprivate var cycleTimer: Timer?
    static func cycleView() -> CycleView {
        let bundle = Bundle.main.loadNibNamed("CycleView", owner: nil, options: nil)
        guard let view = bundle?.first as? CycleView else { return CycleView() }
        return view
    }
}

private let cellID = "CycleCollectionViewCell"
extension CycleView {
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = []
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(UINib(nibName: "CycleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }
}

extension CycleView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (banners?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? CycleCollectionViewCell, let dataArray = banners else { return UICollectionViewCell() }
        cell.backgroundColor = .random()
        cell.getModel(data: dataArray[indexPath.item % dataArray.count])
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x + collectionView.bounds.width * 0.5
        let currentPage = Int(offsetX / collectionView.bounds.width)
        pageControl.currentPage = currentPage % (banners?.count ?? 1)
        
    }
}

extension CycleView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = Int(indexPath.row % ((banners?.count) ?? 1))
        tapAction?(index)
    }
}

extension CycleView {
    fileprivate  func addTimer() {
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
         guard let timer = cycleTimer else { return  }
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
    }
    
    fileprivate  func removeTimer() {
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func timerAction() {
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = collectionView.bounds.width + currentOffsetX
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
