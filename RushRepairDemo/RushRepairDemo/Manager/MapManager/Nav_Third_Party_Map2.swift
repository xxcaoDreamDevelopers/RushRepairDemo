//
//  Nav_Third_Party_Map2.swift
//  IOVS
//
//  Created by 齐云 on 2016/10/11.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit
import MapKit


class Nav_Third_Party_Map2: BaseViewModel, UIActionSheetDelegate {

    var originCoor = CLLocationCoordinate2D()
    var distinationCoor = CLLocationCoordinate2D()
    
    
    
    
    func openNavagate(origin: CLLocationCoordinate2D ,distination: CLLocationCoordinate2D) {
        originCoor = origin
        distinationCoor = distination
        
        let  alertViewController = UIAlertController(title: "跳转导航", message: nil, preferredStyle: .actionSheet)
        
        let baiduMap = UIAlertAction(title: "百度地图", style: .default) { (action) in
            self.baiDu_map_navigete()
        }
        let gaoDeMap = UIAlertAction(title: "高德地图", style: .default) { (action) in
            self.gaoDe_map_navigete()
        }
        let appleMap = UIAlertAction(title: "苹果地图", style: .default) { (action) in
            self.apple_map_navigete()
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        alertViewController.addAction(baiduMap)
        alertViewController.addAction(gaoDeMap)
        alertViewController.addAction(appleMap)
        alertViewController.addAction(cancel)
        
        self.VC?.present(alertViewController, animated: true, completion: nil)
    }
    
    func baiDu_map_navigete() {
        let urlString = "baidumap://map/direction?origin=\(originCoor.latitude),\(originCoor.longitude)&destination=\(distinationCoor.latitude),\(distinationCoor.longitude)&&mode=driving&coord_type=bd09ll"
        if UIApplication.shared.canOpenURL(URL.init(string: BaiDuMap_Navigate)!) {
            UIApplication.shared.openURL(URL.init(string: urlString)!)
        }else {
            self.noneInstallNavigation(string: "百度地图")
        }
    }
    
    func gaoDe_map_navigete() {
        //backScheme=???   必须与白名单保持一致
        let urlString = "iosamap://navi?sourceApplication=XXX&backScheme=iovs&lat=\(distinationCoor.latitude)&lon=\(distinationCoor.longitude)&dev=0&style=2"
        if UIApplication.shared.canOpenURL(URL.init(string: GaodeMap_Navigate)!) {
            UIApplication.shared.openURL(URL.init(string: urlString)!)
        }else {
            self.noneInstallNavigation(string: "高德地图")
        }
    }
    
    func apple_map_navigete() {
        let currentLocation = MKMapItem.forCurrentLocation()
        let plcaemark = MKPlacemark.init(coordinate: distinationCoor, addressDictionary: nil)
        let toLocation = MKMapItem.init(placemark: plcaemark)
        MKMapItem.openMaps(with: [currentLocation, toLocation], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                                                                MKLaunchOptionsShowsTrafficKey: true])
    
    }
   
    
    func noneInstallNavigation(string: String) {
        let alertViewController = UIAlertController(title: "提示", message: "您没有安装\(string)", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (action) in
        }
        alertViewController.addAction(cancel)
        self.VC?.present(alertViewController, animated: true, completion: { 
        })
    }

}
