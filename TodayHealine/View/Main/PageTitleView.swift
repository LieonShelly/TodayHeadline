//
//  PageTitleView.swift
//  TodayHealine
//
//  Created by lieon on 2017/1/16.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

private let scrollowLineH: CGFloat = 1.0
private let zoomScale: CGFloat = 1.2
private let labelCountPerPage: Int = 5
class PageTitleView: UIView {
    var titleTapAction: ((_ index: Int) -> Void)?
    var normalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85) {
        didSet {
            for label in titleLabels {
                label.textColor = UIColor(red: normalColor.0 / 255.0, green: normalColor.1 / 255.0, blue: normalColor.2 / 255.0, alpha: 1)
            }
        }
    }
    var selectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0) {
        didSet {
            scrollLine.backgroundColor = UIColor(red: self.selectColor.0 / 255.0, green: self.selectColor.1 / 255.0, blue: self.selectColor.2 / 255.0, alpha: 1)
            titleLabels[0].textColor = UIColor(red: selectColor.0 / 255.0, green: selectColor.1 / 255.0, blue: selectColor.2 / 255.0, alpha: 1)
        }
    }
    fileprivate var currentIndex: Int = 0 {
        didSet {
            var offsetX: CGFloat = 0
            if currentIndex > labelCountPerPage/2 {
               offsetX = CGFloat(currentIndex) * labelWidth - bounds.width * 0.5 + labelWidth * 0.5
            } else {
                offsetX = 0
            }
             scrollView.setContentOffset(CGPoint(x:offsetX, y: 0), animated: true)
        }
    }
    fileprivate var labelWidth: CGFloat = 0.0
    fileprivate var titles: [String]
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsHorizontalScrollIndicator = false
        sv.showsVerticalScrollIndicator = false
        sv.scrollsToTop = false
        sv.bounces = true
        return sv
    }()
    fileprivate lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor(red: self.selectColor.0 / 255.0, green: self.selectColor.1 / 255.0, blue: self.selectColor.2 / 255.0, alpha: 1)
        return scrollLine
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {
    func setTitle(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        let souceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        let offsetX = targetLabel.frame.origin.x  - souceLabel.frame.origin.x
        let totalX = offsetX * progress
        scrollLine.frame.origin.x = souceLabel.frame.origin.x + totalX
        let colorDelta = (selectColor.0 - normalColor.0, selectColor.1 - normalColor.1, selectColor.2 - normalColor.2)
        souceLabel.textColor = UIColor(red: (selectColor.0 - colorDelta.0 * progress) / 255.0, green: (selectColor.1 - colorDelta.1 * progress) / 255.0, blue: (selectColor.2 - colorDelta.2 * progress) / 255.0, alpha: 1)
        targetLabel.textColor = UIColor(red: (normalColor.0 + colorDelta.0 * progress) / 255.0, green: (normalColor.1 + colorDelta.1 * progress) / 255.0, blue: (normalColor.2 + colorDelta.2 * progress) / 255.0, alpha: 1)
        currentIndex = targetIndex
    }
}

extension PageTitleView {
    fileprivate  func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * frame.width / CGFloat(labelCountPerPage), height: bounds.height)
        setupTtitleLabels()
        setupBottomLineAndScrollLine()
    }
    
    fileprivate  func setupTtitleLabels() {
        let labelW: CGFloat = frame.width / CGFloat(labelCountPerPage)
        labelWidth = labelW
        let labelH: CGFloat = frame.height
        let labelY: CGFloat = 0.0
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(red: normalColor.0 / 255.0, green: normalColor.1 / 255.0, blue: normalColor.2 / 255.0, alpha: 1)
            label.tag = index
            label.textAlignment = .center
            label.text = title
            let labelX = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            titleLabels.append(label)
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabellCilck(tap:)))
            label.addGestureRecognizer(tap)
            
        }
    }
    
    fileprivate  func setupBottomLineAndScrollLine() {
        guard let firtLabel = titleLabels.first else { return  }
        firtLabel.textColor = UIColor(red: selectColor.0 / 255.0, green: selectColor.1 / 255.0, blue: selectColor.2 / 255.0, alpha: 1)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: 0, y: frame.height - scrollowLineH, width: firtLabel.frame.width, height: scrollowLineH)
    }
    
    @objc  private  func titleLabellCilck(tap: UITapGestureRecognizer) {
        guard let selectedLabel = tap.view as? UILabel else { return  }
        let oldLabel = titleLabels[currentIndex]
        oldLabel.textColor = UIColor(red: normalColor.0 / 255.0, green: normalColor.1 / 255.0, blue: normalColor.2 / 255.0, alpha: 1)
        selectedLabel.textColor = UIColor(red: selectColor.0 / 255.0, green: selectColor.1 / 255.0, blue: selectColor.2 / 255.0, alpha: 1)
        currentIndex = selectedLabel.tag
        let offsetX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.1) {
            self.scrollLine.frame.origin.x = offsetX
        }
        if let block = titleTapAction {
            block(selectedLabel.tag)
        }
    }
}
