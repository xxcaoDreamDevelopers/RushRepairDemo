//
//  Base_BaiDuMap.swift
//  IOVS
//
//  Created by 齐云 on 16/9/21.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit

class Base_BaiDuMap: BaesViewController, BMKMapViewDelegate, BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate, BNNaviRoutePlanDelegate, BNNaviUIManagerDelegate, BMKRouteSearchDelegate{

    var mapView:BMKMapView?
    var locSearvice:BMKLocationService?
    var search:BMKGeoCodeSearch?
    var routeSearch:BMKRouteSearch?
    var p_user_location:BMKUserLocation?
    let user_icon: String = "icon_myself_location"  //替换定位点的图标
    var annotations = [BMKAnnotation]()
    var index = 0
    var pinAnnotationArr = [BMKPinAnnotationView]()  //记录地图上的annotationView
    var didSelected_annotation_index = CLLocationCoordinate2D()
    var selectAnnateView = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = BMKMapView(frame: self.view.bounds)
        mapView?.delegate = self;
        mapView?.isSelectedAnnotationViewFront = true;  //将点击的annotationView移动到最上面
        mapView?.userTrackingMode = BMKUserTrackingModeFollow
        
        mapView?.isZoomEnabledWithTap = true
        self.view.addSubview(mapView!);
        //打开实时路况图层
        mapView?.isTrafficEnabled = false;
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mapView?.viewWillAppear()
        mapView?.delegate = self
        routeSearch?.delegate = self
        UIApplication.shared.statusBarStyle = .default //设置状态栏字体颜色
        self.navigationController?.navigationBar.isHidden = true  //隐藏导航条
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mapView?.viewWillDisappear()
        mapView?.delegate = nil
        routeSearch?.delegate = nil
//        if locSearvice != nil {
//            locSearvice?.stopUserLocationService();
//        }
//        if search != nil {
//            search?.delegate = nil
//        }
//        if (mapView?.overlays.count)! > 0 {
//            mapView?.removeOverlays(mapView?.overlays)
//        }
//        if (mapView?.annotations.count)! > 0 {
//            mapView?.removeAnnotations(mapView?.annotations)
//        }
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.isHidden = false
    }
    
    //地图初始化完毕时会调用此接口
    func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        //初始化暂不定位
//        baiDu_map_location()
        changeUserIcon(icon: user_icon)
    }
    //地图状态改变完成后会调用此接口
    func mapStatusDidChanged(_ mapView: BMKMapView!) {
        
    }
    //点中底图空白处会回调此接口
    func mapView(_ mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        
    }
    //点中底图标注后会回调此接口
    func mapView(_ mapView: BMKMapView!, onClickedMapPoi mapPoi: BMKMapPoi!) {
        
    }
    //双击地图时会回调此接口
    func mapview(_ mapView: BMKMapView!, onDoubleClick coordinate: CLLocationCoordinate2D) {
        
    }
    //长按地图时会回调此接口
    func mapview(_ mapView: BMKMapView!, onLongClick coordinate: CLLocationCoordinate2D) {
        
    }
    // 地图渲染每一帧画面过程中，以及每次需要重绘地图时（例如添加覆盖物）都会调用此接口
    func mapView(_ mapView: BMKMapView!, onDrawMapFrame status: BMKMapStatus!) {
        //        setLocationViewAngle(angle: currentAngle!)
    }
    //点中覆盖物后会回调此接口，目前只支持点中BMKPolylineView时回调
    func mapView(_ mapView: BMKMapView!, onClickedBMKOverlayView overlayView: BMKOverlayView!) {

    }
    // 3DTouch 按地图时会回调此接口（仅在支持3D Touch，且fouchTouchEnabled属性为YES时，会回调此接口）
    func mapview(_ mapView: BMKMapView!, onForceTouch coordinate: CLLocationCoordinate2D, force: CGFloat, maximumPossibleForce: CGFloat) {
        
    }
    //根据anntation生成对应的View
    func mapView(_ mapView: BMKMapView!, viewFor annotation: BMKAnnotation!) -> BMKAnnotationView! {
        if annotation is BMKUserLocation {
            return nil
        }
        if annotation is BMKPointAnnotation {
            let resuerId = "myAnnotation"
            var newAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: resuerId) as? BMKPinAnnotationView
            if newAnnotation == nil {
                newAnnotation = BMKPinAnnotationView.init(annotation: annotation, reuseIdentifier: resuerId)
                newAnnotation?.animatesDrop = true
                newAnnotation?.canShowCallout = false
                newAnnotation?.image = UIImage(named: "icon_location_Charging_Point")
            }
            newAnnotation?.tag = 20000 + index
            index = index + 1
            pinAnnotationArr.append(newAnnotation!)
            return newAnnotation
        }
        return nil
    }

    //当mapView新添加annotation views时，调用此接口
    func mapView(_ mapView: BMKMapView!, didAddAnnotationViews views: [Any]!) {

    }
    //当选中一个annotation views时，调用此接口
    func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
//        if view.isKind(of:NSClassFromString("LocationView")!) {
//            return;
//        }
        selectAnnateView = view.tag
        mapView.setCenter(view.annotation.coordinate, animated: true)
        didSelected_annotation_index = view.annotation.coordinate
        view.image = UIImage(named: "icon_location_Charging_Point_pitch_on")
        for i in 0 ..< pinAnnotationArr.count {
            if i != (view.tag - 20000) {
                let annotationView = pinAnnotationArr[i]
                annotationView.image = UIImage(named: "icon_location_Charging_Point")
            }
        }
    }

    //当取消选中一个annotation views时，调用此接口
    func mapView(_ mapView: BMKMapView!, didDeselect view: BMKAnnotationView!) {
        
    }
    //当点击annotation view弹出的泡泡时，调用此接口
    func mapView(_ mapView: BMKMapView!, annotationViewForBubble view: BMKAnnotationView!) {
        
    }
    //拖动annotation view时，若view的状态发生变化，会调用此函数。ios3.2以后支持
    func mapView(_ mapView: BMKMapView!, annotationView view: BMKAnnotationView!, didChangeDragState newState: UInt, fromOldState oldState: UInt) {
        
    }
    //地图区域改变完成后会调用此接口
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        
    }
    //地图区域即将改变时会调用此接口
    func mapView(_ mapView: BMKMapView!, regionWillChangeAnimated animated: Bool) {
        
    }
    //根据overlay生成对应的View
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if overlay.isKind(of: BMKPolyline.classForCoder()) {
            let polylineView: BMKPolylineView = BMKPolylineView.init(overlay: overlay)
            polylineView.fillColor = UIColor(hexString: "#1a87fa")
            polylineView.strokeColor = UIColor(hexString: "#1a87fa")
            polylineView.lineWidth = 5
            return polylineView
        }
        return nil
    }

    //当mapView新添加overlay views时，调用此接口
    func mapView(_ mapView: BMKMapView!, didAddOverlayViews overlayViews: [Any]!) {
        
    }
    //地图进入/移出室内图会调用此接口
    func mapview(_ mapView: BMKMapView!, baseIndoorMapWithIn flag: Bool, baseIndoorMapInfo info: BMKBaseIndoorMapInfo!) {
        
    }
    

//定位
    func baiDu_map_location() {
        locSearvice = BMKLocationService()
        locSearvice?.delegate = self
        locSearvice?.startUserLocationService()
    }
    
    //在将要启动定位时，会调用此函数
    func willStartLocatingUser() {
        NSLog("message:%@", "定位将要开启")
    }
    
    //在停止定位后，会调用此函数
    func didStopLocatingUser() {
        NSLog("message:%@", "定位取消")
    }
    
    //用户方向更新后，会调用此函数
    func didUpdateUserHeading(_ userLocation: BMKUserLocation!) {

    }
    
    
    //用户位置更新后，会调用此函数
    func didUpdate(_ userLocation: BMKUserLocation!) {
//        location!(userLocation)
        p_user_location = userLocation
        mapView?.showsUserLocation = true//显示定位图层
        mapView?.updateLocationData(userLocation) //更新定位
        
//        let region = BMKCoordinateRegion(center: userLocation.location.coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1))
//        mapView?.setRegion(region, animated: true)
        
        
    }
    
    //定位失败后，会调用此函数
    func didFailToLocateUserWithError(_ error: Error!) {
        NSLog("message: %@",  error.localizedDescription);
    }
    
//反编码
    func baiDu_map_GeoCodeSearch(coor:CLLocationCoordinate2D) {
        if search != nil {
            search = BMKGeoCodeSearch()
            search?.delegate = self
        }
        let reaciver = BMKReverseGeoCodeOption()
        reaciver.reverseGeoPoint = coor
        let flag = search?.reverseGeoCode(reaciver)
        if flag == true{
            NSLog("message: %@", "反geo检索发送成功")
        }else {
            NSLog("message: %@", "反geo检索发送失败")
        }
        
    }
    
    //返回地址信息搜索结果
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        
    }
    
    //返回反地理编码搜索结果
    func onGetReverseGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKReverseGeoCodeResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
//            let address:String = result.address;
//            geoCodeResult!(address)
        }else {
            NSLog("message : %@", "抱歉,未能找到结果")
        }
    }
    
//修改定位图标
    func changeUserIcon(icon: String) {
        let parm = BMKLocationViewDisplayParam();
        parm.isRotateAngleValid = true;
        parm.isAccuracyCircleShow = true;
        parm.locationViewImgName = icon;
        parm.locationViewOffsetX = 0;
        parm.locationViewOffsetY = 0;
        mapView!.updateLocationView(with: parm)
    }
    
//添加图标
    func addAnnotation(coors: [CLLocationCoordinate2D]) {
        if coors.count == 0 {
            return
        }
        index = 0
        //移除标注
        if (mapView?.annotations.count)! > 0 {
            mapView?.removeAnnotations(mapView?.annotations)
        }
        annotations.removeAll()
        //移除路径规划
        if (mapView?.overlays.count)! > 0 {
            mapView?.removeOverlays(self.mapView?.overlays)
        }
        
        for i in 0 ..< coors.count {
            let annotation: BMKPointAnnotation  = BMKPointAnnotation()
            annotation.coordinate = coors[i]
            annotation.title = ""
            annotations.append(annotation)
        }
        pinAnnotationArr.removeAll()
        mapView?.addAnnotations(annotations)
        mapView?.showAnnotations(annotations, animated: true)
    }
    
//开始导航
    func letGoThere(startCoor: CLLocationCoordinate2D, endCoor:CLLocationCoordinate2D ,palnMode_type: BNRoutePlanMode) {
        if !checkServicesInited() {
            return
        }
        var nodesArr = [Any]()
        
        let startNode = BNRoutePlanNode()
        startNode.pos = BNPosition()
        startNode.pos.x = startCoor.longitude
        startNode.pos.y = startCoor.latitude
        startNode.pos.eType = BNCoordinate_BaiduMapSDK
        nodesArr.append(startNode)
        
        let endNode = BNRoutePlanNode()
        endNode.pos = BNPosition()
        endNode.pos.x = endCoor.longitude
        endNode.pos.y = endCoor.latitude
        endNode.pos.eType = BNCoordinate_BaiduMapSDK
        nodesArr.append(endNode)
        
        BNCoreServices.routePlanService().startNaviRoutePlan(palnMode_type, naviNodes: nodesArr, time: nil, delegete: self, userInfo: nil)
        
    }
    
    
    func checkServicesInited() -> Bool {
        if  !BNCoreServices.getInstance().isServicesInited() {
            
            
            
            
            
//            LBXAlertAction.showAlert(withTitle: "提示", msg: "引擎尚未初始化完成，请稍后再试", choose: { (index) in
//                
//                }, buttonsStatement: "取消")
            return false
        }else {
            return true
        }
    }
    
    //算路成功
    func routePlanDidFinished(_ userInfo: [AnyHashable : Any]!) {
        NSLog("message : %@", "熟路成功")
        //路径规划成功，开始导航
        BNCoreServices.uiService().showNaviUI(BN_NaviTypeSimulator, delegete: self, isNeedLandscape: true)
    }
    
    //算路取消
    func routePlanDidUserCanceled(_ userInfo: [AnyHashable : Any]!) {
        NSLog("message : %@", "算路成功")
    }
    
    //算路失败
    func routePlanDidFailedWithError(_ error: Error!, andUserInfo userInfo: [AnyHashable : Any]! = [:]) {
        NSLog("message : %@", "算路失败")
        NSLog("message : %@", error.localizedDescription)
    }
    
    
    
    //退出导航
    func onExitNaviUI(_ extraInfo: [AnyHashable : Any]!) {
        NSLog("message : %@", "退出导航")
        BNCoreServices.releaseInstance()  //释放单体
        BNCoreServices.getInstance().stop()  //停止所有服务
    }
    
    //退出导航声明页面
    func onExitexitDeclarationUI(_ extraInfo: [AnyHashable : Any]!) {
        NSLog("message : %@", "退出导航声明页面")
    }
    
    func onExitDigitDogUI(_ extraInfo: [AnyHashable : Any]!) {
        NSLog("message : %@", "退出电子狗页面")
    }
    
    
    
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
