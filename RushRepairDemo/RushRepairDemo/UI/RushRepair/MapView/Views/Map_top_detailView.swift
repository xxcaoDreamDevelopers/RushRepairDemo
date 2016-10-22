//
//  Map_DetailView.swift
//  IOVS
//
//  Created by 齐云 on 16/9/26.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit
typealias navigate_btn = (_ btn: UIButton) ->Void


class Map_top_detailView: UIView {

    var home_bottomView_detail: UILabel?  //显示工单来源
    var backView: UILabel? //显示工单来源数量
    var navigate_btnClicked: navigate_btn?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        home_bottomView_detail = UILabel(frame: CGRect(x: 1, y: 0, width: frame.width, height: frame.height))
        home_bottomView_detail?.backgroundColor = UIColor.white
        self.addSubview(home_bottomView_detail!)
        home_bottomView_detail?.layer.cornerRadius = (home_bottomView_detail?.height)! / 2
        home_bottomView_detail?.layer.masksToBounds = true
        home_bottomView_detail?.textAlignment = .center
//        home_bottomView_detail?.text = "工单来源: 平台检测"
        home_bottomView_detail?.font = UIFont.systemFont(ofSize: 13)
        
        
        let navigate_btn:UIButton = UIButton(type: .custom)
        navigate_btn.frame = CGRect(x: -1, y: 0, width: 47, height: 47)
        navigate_btn.setBackgroundImage(UIImage.init(named: "btn_logo"), for: UIControlState.normal)
        self.addSubview(navigate_btn)
        self.bringSubview(toFront: navigate_btn)
        
        navigate_btn.handle(UIControlEvents.touchUpInside) { (button) in

            self.navigate_btnClicked!(navigate_btn)

        }

        
        backView = UILabel(frame: CGRect(x: self.width - 45, y: 0, width: 47, height: 44.5))
        backView?.layer.cornerRadius = (backView?.height)! / 2
        backView?.layer.masksToBounds = true
        backView?.layer.borderWidth = 0.6
        backView?.layer.borderColor = UIColor.init(hexString: "#d9d9d9").cgColor
        home_bottomView_detail?.addSubview(backView!)
//        backView?.text = "12"
        backView?.textAlignment = .center
        backView?.textColor = UIColor.orange
        backView?.font = UIFont.boldSystemFont(ofSize: 20)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
