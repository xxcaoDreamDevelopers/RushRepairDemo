//
//  BaesViewController.swift
//  IOVS
//
//  Created by 齐云 on 16/9/20.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit
//import SnapKit

class BaesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false;
        self.edgesForExtendedLayout = .all;
        
        Q_Log(message: "生命周期--创建" + (NSString.self() as String));
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        Q_Log(message: "生命周期--内存报警" + (NSString.self() as String))
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Q_Log(message: "生命周期--显示" + (NSString.self() as String))
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        Q_Log(message: "生命周期--消失" + (NSString.self() as String))
    }
    
    deinit {
        Q_Log(message: "生命周期--销毁" + (NSString.self() as String))
    }
    
    func scanCode(_ btnClicked: (_ scanClicked: UIButton) ->() ) {
        let scanBtn = UIButton(type: .custom)
        scanBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnClicked(scanBtn)
        scanBtn.setImage(UIImage.init(named: "icon-scanCode"), for: .normal)
        let barItem = UIBarButtonItem(customView: scanBtn)
        navigationItem.rightBarButtonItem = barItem
    }


   
    
    
    
    
}
