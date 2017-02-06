//
//  SegmentView.swift
//  TodayHealine
//
//  Created by lieon on 2017/2/6.
//  Copyright © 2017年 ChangHongCloudTechService. All rights reserved.
//

import UIKit

private let segCountPerPage: Int = 3
private let scrolllineHeight: CGFloat = 2
class SegmentView: UIView {
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    fileprivate lazy var titles: [String] = [String]()
    fileprivate lazy var buttons: [UIButton] = [UIButton]()
    fileprivate lazy var scrollline: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.red
        return line
    }()
    fileprivate lazy var selectedButton: UIButton = UIButton()
    fileprivate lazy var titleWidths: [CGFloat] = [CGFloat]()
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        self.titles = titles
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWidth = bounds.width / CGFloat(segCountPerPage)
        scrollView.frame = self.bounds
        scrollView.contentSize = CGSize(width: buttonWidth * CGFloat(titles.count), height: 0)
        for button in buttons {
            button.frame = CGRect(x: CGFloat(button.tag) * buttonWidth, y: 0, width: buttonWidth, height: bounds.height - scrolllineHeight)
        }
        scrollline.bounds.size = CGSize(width: titleWidths[0], height: scrolllineHeight)
        scrollline.center.x = buttons[0].center.x
        scrollline.center.y = buttons[0].frame.maxY + scrolllineHeight * 0.5
        
    }
}

extension SegmentView {
    fileprivate func setupUI() {
        var i: Int = 0
        addSubview(scrollView)
        self.titles.forEach { title in
            let button = UIButton()
            button.setTitleColor(UIColor.darkGray, for: .normal)
            button.setTitleColor(.red, for: .selected)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.tag = i
            button.addTarget(self, action: #selector(self.tapAction(button:)), for: .touchUpInside)
            scrollView.addSubview(button)
            self.buttons.append(button)
            let titleWidth = self.titleWidth(title: button.title(for: .normal))
            self.titleWidths.append(titleWidth)
            i = i + 1
        }
        scrollView.addSubview(scrollline)
        tapAction(button: buttons[0])
    }
    
    fileprivate func titleWidth(title: String?) -> CGFloat {
        guard let text = title else { return  0.0 }
        let buttonWidth = bounds.width / CGFloat(segCountPerPage)
        let nstitle = NSString(string: text)
        let size = nstitle.boundingRect(with: CGSize(width: buttonWidth, height: 2), options: NSStringDrawingOptions.init(rawValue: 0), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil).size
        let inset: CGFloat = 5
        return size.width + inset * 2
    }
    
    @objc private func tapAction(button: UIButton) {
        selectedButton.isSelected = false
        button.isSelected = true
        selectedButton = button
        scrollline.bounds.size.width = titleWidths[selectedButton.tag]
        if selectedButton.center.x > bounds.width * 0.5  && buttons.count > segCountPerPage {
            scrollView.setContentOffset(CGPoint(x: selectedButton.frame.maxX - bounds.width * 0.5 - selectedButton.bounds.width * 0.5, y: 0), animated: false)
        } else {
           scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
        UIView.animate(withDuration: 0.25) { 
            self.scrollline.center.x = self.selectedButton.center.x
        }
    }
}
