//
//  comment.swift
//  IOVS
//
//  Created by 齐云 on 16/9/20.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import Foundation


//打印
func Q_Log<T>(message : T, file : String = #file, lineNumber : Int = #line) {
    
    #if DEBUG
        
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):line:\(lineNumber)]- \(message)")
        
    #endif
}

//百度地图Key

//let BaiDuMap_key:String = "mOhy25vW0lFMdIr5KHPTP9a7VbZGrZq4"   //upbest.IOVS

let BaiDuMap_key:String = "eeacRwnflYT5Ge03wP4bzeYOhGmQADU7"   //upbest.IOVSaaa
let BaiDuMap_Nav_AppCode: String = "ac323a02854be8336311ff92bf0271f3"

//跳转第三方导航
let BaiDuMap_Navigate: String = "baidumap://"
let GaodeMap_Navigate: String = "iosamap://"
let AppleMap_Navigate: String = "asd"




let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height


//根据字符转计算长度
func Q_getTextRectSize(text:String,font:UIFont,size:CGSize) -> CGRect {
    let attributes = [NSFontAttributeName: font]
    let option = NSStringDrawingOptions.usesLineFragmentOrigin
    let rect:CGRect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
    return rect;
}

//根据类名生成类
func Q_addChildViewController(_ childControllerName : String) ->UIViewController? {
    // 1.获取命名空间
    guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
        Q_Log(message: "命名空间不存在")
        return nil
    }
    // 2.通过命名空间和类名转换成类
    let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
    guard let clsType = cls as? UIViewController.Type else {
        Q_Log(message: "无法转换成UIViewController")
        return nil
    }
    // 3.通过Class创建对象
    let childController = clsType.init()
    return childController
}

//视图圆角
func Q_viewFillet(view: UIView ,redius: CGFloat) {
    view.layer.cornerRadius = redius
    view.layer.masksToBounds = true
}

func Q_viewFilletAndBord(view: UIView, redius: CGFloat, borderWidth: CGFloat, borderColor: String) {
    Q_viewFillet(view: view, redius: redius)
    view.layer.borderWidth = borderWidth
    view.layer.borderColor = UIColor.init(hexString: borderColor).cgColor
}



//}




