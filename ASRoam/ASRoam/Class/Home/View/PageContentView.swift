//
//  PageContentView.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/6/5.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit


protocol PageContentViewDelegate: class {
    func pageContentView(progress: CGFloat, currentIndex: Int, targetIndex: Int)
}

class PageContentView: UIView, UICollectionViewDataSource, UICollectionViewDelegate{
    
    weak var delegate: PageContentViewDelegate?
    //MARK: -定义属性
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    
    //开始的偏移量
    fileprivate var startOfSetX: CGFloat = 0
    fileprivate var signWeatherIsDraw:Bool = false

    
//    //MARK: -懒加载collectionView
    fileprivate lazy var collectionView: UICollectionView = {[weak self] in
        //1.创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white

        
        //注册单元格
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HomePageCell")
        return collectionView
        
        
        
    }();
    //MARK: -重写构造函数
    init(frame: CGRect, childVcs: [UIViewController], parentViewController: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentViewController
        
        
        super.init(frame: frame)
        //setupUI
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageContentView {
    fileprivate func setupUI() {
        //1.将子控制器添加到父控制器
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
        //2.添加UICollectionView
        addSubview(collectionView)
        collectionView.delegate = self as UICollectionViewDelegate
        collectionView.dataSource = self as UICollectionViewDataSource
//        collectionView.decelerationRate = 01

    }
    
}


//MARK: -遵守UICollectionViewDatasource
extension PageContentView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomePageCell", for: indexPath)
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
    
}

//MARK: -遵守UICollectionViewDelegate
extension PageContentView {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOfSetX = scrollView.contentOffset.x
        
//        print("startOfSetX****\(startOfSetX)")

        signWeatherIsDraw = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if signWeatherIsDraw == false {
            return
        }
        //1.定义需要的数据
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        //2.判断是左滑还是右滑
        let currentOfSetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width

//        print("****\(currentOfSetX)")

        //越界直接返回
        if currentOfSetX < 0 {
            sourceIndex = 0
            targetIndex = 0

            return
        }else if currentOfSetX > scrollViewW*CGFloat(self.childVcs.count - 1){
            sourceIndex = self.childVcs.count - 1
            targetIndex = self.childVcs.count - 1

            return
        }


        if currentOfSetX > startOfSetX {//左滑
                        //1.计算progress
            progress = currentOfSetX/scrollViewW - floor(currentOfSetX/scrollViewW)
            //2.sourceIndex
            sourceIndex = Int(currentOfSetX/scrollViewW)
            //3.targetIndex
            targetIndex = sourceIndex + 1
            
            if targetIndex >= self.childVcs.count {
                targetIndex = self.childVcs.count - 1
            }
            
            if currentOfSetX - startOfSetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
            
        }else{//右hua
            
            //1.计算progress
            progress = 1 - currentOfSetX/scrollViewW + floor(currentOfSetX/scrollViewW)
            //2.targetIndex
            targetIndex = Int(currentOfSetX/scrollViewW)
            //3.sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= self.childVcs.count {
                sourceIndex = self.childVcs.count - 1
            }
            
        }
        
       

//        print("sourceIndex:\(sourceIndex)    targetIndex:\(targetIndex) /n \(progress)")
        delegate?.pageContentView(progress: progress, currentIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}



//MARK: -对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        signWeatherIsDraw = false
        let indexPath = IndexPath(row: currentIndex, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)

    }
}




