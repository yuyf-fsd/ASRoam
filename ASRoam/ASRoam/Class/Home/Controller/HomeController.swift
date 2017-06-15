//
//  HomeController.swift
//  ASRoam
//
//  Created by Yanfei Yu on 2017/5/18.
//  Copyright © 2017年 Ataluer. All rights reserved.
//

import UIKit

class HomeController: UIViewController, PageContentViewDelegate {
    
    
    //MARK: -懒加载PageTitleView
    fileprivate lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleView = PageTitleView(frame: CGRect(x: 0, y: 64, width: kScreenW, height: 40), titles: ["推荐", "体育", "娱乐", "趣玩"], clickBlock: { (NSInteger) -> (Void) in
            self?.pageContentView.setCurrentIndex(currentIndex: NSInteger)
        })
        return titleView
    }()
    
    //MARK: - 懒加载PageContentView
    fileprivate lazy var pageContentView: PageContentView = {
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let pageContentView = PageContentView(frame: CGRect(x: 0, y: 104, width: kScreenW, height: kScreenH-104-49), childVcs: childVcs, parentViewController: self)
        return pageContentView
    }()

    // MARK: -系统回掉函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.设置UI界面
        setupUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension HomeController {
    fileprivate func setupUI() {
        //1.设置导航栏
        setupNavigationBar()
        //2.添加titleview
        view.addSubview(pageTitleView)
        
        //3.添加contentCollection
        view.addSubview(pageContentView)
        pageContentView.delegate = self
        
    }
    
    private func setupNavigationBar() {
        
        self.automaticallyAdjustsScrollViewInsets = false

        //1.设置左边的图片按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //2.设置右边的按钮
        let btnSize = CGSize(width: 40, height: 40)
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: btnSize)

        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: btnSize)

        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: btnSize)

        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
    }
        

    
}

// MARK: -PageContentViewDelegate
extension HomeController {
    func pageContentView(progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        self.pageTitleView.setTitleWithProgress(progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}
