//
//  MapTaskViewData.swift
//  IOVS
//
//  Created by 齐云 on 2016/10/17.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit

class MapTaskViewData: NSObject {
    
    func configData() -> NSArray {
        let path = Bundle.main.path(forResource: "mapdata.plist", ofType: nil)
        let dataArr = NSArray(contentsOfFile: path!)
        var firstArr = [Any]()
        for i in 0 ..< dataArr!.count {
            let secondDataArr = dataArr?[i] as! NSArray
            var thirdArr = [Any]()
            for j in 0 ..< secondDataArr.count {
                let thirdDataArr = secondDataArr[j] as! NSArray
                var fouthArr = [TaskModel]()
                for k in 0 ..< thirdDataArr.count {
                    let fouthDataArr = thirdDataArr[k] as! [String : Any]
                    let mode = TaskModel()
                    mode.configDataArr(fouthDataArr)
                    fouthArr.append(mode)
                }
                thirdArr.append(fouthArr)
            }
            firstArr.append(thirdArr)
        }
        return firstArr as NSArray
    }
    
    
}
