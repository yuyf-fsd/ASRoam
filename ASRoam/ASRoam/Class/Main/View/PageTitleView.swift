//
//  PageTitleView.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/5/18.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

typealias ClickBlock = (NSInteger) -> (Void)


class PageTitleView: UIView {
    
    //MARK: -懒加载scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK: -懒加载scrolLine
    fileprivate lazy var scrollLine: UILabel = {
        let scrollLine = UILabel()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    //MARK: -定义属性
    fileprivate var titles: [String]
    fileprivate var labelW:CGFloat = 0
    fileprivate var currentSelectIndex:NSInteger = 0
    fileprivate var block: ClickBlock

    

   //MARK: -自定义构造函数
    init(frame: CGRect, titles: [String], clickBlock: @escaping (NSInteger) -> (Void)) {
        self.titles = titles
        block = clickBlock
        super.init(frame: frame)
        
        
        //1.UI操作
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView{
    fileprivate func setupUI() {
        //1.添加scrollView
        
        addSubview(scrollView)
        scrollView.frame = bounds
        
        //2.添加title对应的label
        addTitleLabel()
        
        
        //3.设置底线和滑块
        setupBottomMenuAndScrollLine()
        
    }
    
    
    fileprivate func addTitleLabel() {
        if self.titles.count > 4 {
            labelW = CGFloat(kScreenW/5)
        }else{
            labelW = CGFloat(kScreenW/CGFloat(self.titles.count))
        }
        let labelH = frame.height - 2
        
        for (index, title) in titles.enumerated() {
            //1.创建label
            let label = UILabel()
            label.text = title
            label.tag = index+1
            if index == 0 {
                label.textColor = UIColor.orange
            }
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.frame = CGRect(x: labelW * CGFloat(index), y: 0, width: labelW, height: labelH)
            scrollView.addSubview(label)
            scrollView.contentSize = CGSize(width: label.frame.origin.x+labelW, height: 40)
            
            //2.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    fileprivate func setupBottomMenuAndScrollLine() {
        //1.设置底线
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        lineView.frame = CGRect(x: 0, y: bounds.size.height-0.5, width: scrollView.contentSize.width, height: 0.5)
        scrollView.addSubview(lineView)
        
        //2.设置scrollLine
        scrollLine.frame = CGRect(x: 0, y: bounds.size.height-2, width: labelW, height: 2)
        scrollView.addSubview(scrollLine)
        
        
    }

}


// MARK: -监听label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer) {
        let lastLabel:UILabel = (scrollView.viewWithTag(currentSelectIndex+1)) as! UILabel
        lastLabel.textColor = UIColor.darkGray
        let currentLabel:UILabel = tapGes.view as! UILabel
        currentSelectIndex = currentLabel.tag-1
        currentLabel.textColor = UIColor.orange
        UIView.animate(withDuration: 0.3) { 
            self.scrollLine.frame.origin.x = CGFloat(self.currentSelectIndex) * self.labelW
        }
        block(currentSelectIndex)

        
        if titles.count <= 4 {
            return
        }
        
        var scrollViewX = currentLabel.frame.origin.x - 2*labelW
        if  scrollViewX < 0 {
            scrollViewX = 0
        }
        
        if scrollViewX > (scrollView.contentSize.width - bounds.width) {
            scrollViewX = (scrollView.contentSize.width - bounds.width)
        }
        
        UIView.animate(withDuration: 0.3) { 
            self.scrollView.contentOffset = CGPoint(x: scrollViewX, y: 0)
        }
        
        
    }
}

// MARK: -对外暴露的方法
extension PageTitleView {
    func setTitleWithProgress(progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        //1.取出两个label
        let currentLabel = self.scrollView.viewWithTag(currentIndex+1)
        let targetLabel = self.scrollView.viewWithTag(targetIndex+1)
        
        //2.处理滑块
        let distance = (currentLabel?.frame.origin.x)! - (targetLabel?.frame.origin.x)!
        let timeDistance = distance * progress
        scrollLine.frame.origin.x = (currentLabel?.frame.origin.x)! - timeDistance
        
        
        let rDistance:CGFloat = 255 - 0
        let gDistance:CGFloat = 128 - 0
        let bDistance:CGFloat = 0 - 0

        //3.处理颜色
        (currentLabel as! UILabel).textColor = UIColor(r: 255-(rDistance * progress), g: 128-(gDistance * progress), b: 0-(bDistance * progress))
        (targetLabel as! UILabel).textColor = UIColor(r: 0+(rDistance * progress), g: 0+(gDistance * progress), b: 0+(bDistance * progress))
        
        if currentLabel == targetLabel {
            (currentLabel as! UILabel).textColor = UIColor(r: 255, g: 128, b: 0)
        }
        currentSelectIndex = targetIndex
        
        
        
        
        if titles.count <= 4 {
            return
        }
        
        let currentLabell = self.scrollView.viewWithTag(currentSelectIndex+1)

        var scrollViewX = (currentLabell?.frame.origin.x)! - 2*labelW
        if  scrollViewX < 0 {
            scrollViewX = 0
        }
        
        if scrollViewX > (scrollView.contentSize.width - bounds.width) {
            scrollViewX = (scrollView.contentSize.width - bounds.width)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView.contentOffset = CGPoint(x: scrollViewX, y: 0)
        }

    }
}
