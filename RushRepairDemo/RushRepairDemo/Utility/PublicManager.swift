//
//  PublicManager.swift
//  IOVS
//
//  Created by 齐云 on 2016/10/11.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit

class PublicManager: NSObject {

    func getCurrentVC()->UIViewController?{
        var result:UIViewController?
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal{
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if tmpWin.windowLevel == UIWindowLevelNormal{
                    window = tmpWin
                    break
                }
            }
        }
        
        let fromView = window?.subviews[0]
        if let nextRespnder = fromView?.next{
            if nextRespnder is UIViewController{
                result = nextRespnder as? UIViewController
            }else{
                result = window?.rootViewController
            }
        }
        return result
    }

    
    
    
    
}
