//
//  Map_bottom_detailView.swift
//  IOVS
//
//  Created by 齐云 on 16/9/26.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit

class Map_bottom_detailView: UIView {

    var detailView:UIView?  //底部视图
    var order_from_btn_type = { (type: EFilterType, parentIndex: EItemType , isSelected: Bool) -> Void in
    
    }
    
    var bottomView: HomeBottomView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView = HomeBottomView.init(frame: frame)
        bottomView?.backgroundColor = UIColor.white
        self.addSubview(bottomView!)
        bottomView?.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        
        
        bottomView?.filterBlock = {(type, parentIndex, isSeleted) in
            self.order_from_btn_type(type, parentIndex, isSeleted)
        }
        
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
