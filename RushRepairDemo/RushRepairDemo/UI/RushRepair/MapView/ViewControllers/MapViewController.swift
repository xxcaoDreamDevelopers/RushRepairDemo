//
//  MapViewController.swift
//  IOVS
//
//  Created by 齐云 on 16/9/21.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

import UIKit
enum TaskType {
    case temporaryRepair  //临检
    case repair           //检修
    case perambulate      //巡视
    case failure          //失败
}

enum Bottom_View_Show_Form {
    case view_top
    case view_middle
    case view_bottom
}

class MapViewController: Base_BaiDuMap, UIGestureRecognizerDelegate {
    
    let animateTime = 0.3   //动画时长
    
    var panTemp: CGFloat = 0
    var table_detailView: TaskDetailView?
    var tableManager: TaskDetailTableManager?
    var map_zoom = false
    var isShow_top_detailView = false
    var taskType: EItemType = .customService
    
    var failure:EFilterType = .sourceSpecialTour
    
    
    var showPlanRoute = true    //默认状态下,出现路径规划是点击地图空白处不起作用
    var task_detailTable: TaskDetailTable?
    
    var tempDataArr = [CLLocationCoordinate2D]()
    var first_dataArr = [[TaskModel]]()
    var secong_dataArr = [[TaskModel]]()
    var third_dataArr = [[TaskModel]]()
    var fouth_dataArr = [[TaskModel]]()
    var five_dataArr = [[TaskModel]]()
    
    var dataArr = [[TaskModel]]()
    var firstArr = [TaskModel]()
    var secondArr = [TaskModel]()
    var isNumArr = true  //true 一级数组  false 二级数组
    var bottom_view_show_form = Bottom_View_Show_Form.view_top
    
    lazy var location_btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: "icon_location"), for: UIControlState.normal)
        self.view.addSubview(btn)
        self.view.bringSubview(toFront: btn)
        return btn
    }()
    
    lazy var navigate_btn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 14, y: SCREEN_HEIGHT - 181, width: 0, height: 40)
        btn.setBackgroundImage(UIImage.init(named: "icon_navigation"), for: UIControlState.normal)
        return btn
    }()
    
    lazy var map_detailView: Map_top_detailView = {
        let detailView = Map_top_detailView.init(frame: CGRect(x: 15.5, y: 28, width: SCREEN_WIDTH - 31, height: 44.5))
        return detailView
    }()
    
    lazy var map_bottom_detailView: Map_bottom_detailView = {
        let map_bottom = Map_bottom_detailView.init(frame: CGRect(x: 0, y: SCREEN_HEIGHT - 75, width: SCREEN_WIDTH, height: 140))
        return map_bottom
    }()
    
    lazy var finshNavigate: UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 14, y: SCREEN_HEIGHT - 71, width: 0, height: 47)
        btn.setTitle("结束导航", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.red
        btn.layer.cornerRadius = 5
        btn.layer.masksToBounds = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func mapViewDidFinishLoading(_ mapView: BMKMapView!) {
        super.mapViewDidFinishLoading(mapView)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.showAnnotation()
        }
    }
    
    override func mapView(_ mapView: BMKMapView!, didSelect view: BMKAnnotationView!) {
        if !showPlanRoute || view.isKind(of:NSClassFromString("LocationView")!) {   //路径规划时或点击自己图标,不可点
            return
        }
        super.mapView(mapView, didSelect: view)
        if isNumArr {
            congifTaskDetailTable(task: firstArr[view.tag - 20000])
        }else {
            congifTaskDetailTable(task: secondArr[view.tag - 20000])
        }
        viewForm_bottom(form: .view_middle)
        display_tableView_detailView(true)
    }
    
    //点击地图空白地方
    override func mapView(_ mapView: BMKMapView!, onClickedMapBlank coordinate: CLLocationCoordinate2D) {
        if !showPlanRoute {    //路径规划.不可点击
            return
        }
        super.mapView(mapView, onClickedMapBlank: coordinate)
        for i in 0 ..< pinAnnotationArr.count {
            let annotationView = pinAnnotationArr[i]
            annotationView.image = UIImage(named: "icon_location_Charging_Point")
        }
        viewForm_bottom(form: .view_middle)
        display_tableView_detailView(false)
    }
    
    //地图缩放后调用
    override func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        super.mapView(mapView, regionDidChangeAnimated: animated)
        if map_zoom {
            mapView.zoomLevel -= 1
        }
        map_zoom = false
    }
    
    func loadData() {
        let mapData = MapTaskViewData()
        let dataArrPlist = mapData.configData()
        first_dataArr = dataArrPlist[0] as! [[TaskModel]]
        secong_dataArr = dataArrPlist[1] as! [[TaskModel]]
        third_dataArr = dataArrPlist[2] as! [[TaskModel]]
        fouth_dataArr = dataArrPlist[3] as! [[TaskModel]]
        five_dataArr = dataArrPlist[4] as! [[TaskModel]]
        dataArr = first_dataArr
    }
    
    func initUI() {
        //添加底部工单类型视图
        add_map_top_detailView()
        
        //添加定位图标
        add_location_btn()
        
        //添加底部视图View
        add_map_bottom_detailView()
        
        //添加导航图标
        add_navigate_btn()

        //添加结束导航图标
        add_finsh_navigate()
        
        //添加单个工单详情
        add_taskDetail()
    }
    
    func add_taskDetail() {
        table_detailView = TaskDetailView(isNewTask: false)
        table_detailView?.frame = CGRect(x: 0, y: -120, width: SCREEN_WIDTH, height: 92)
        table_detailView?.clipsToBounds = true
        table_detailView?.backgroundColor = UIColor.white
        self.view.addSubview(table_detailView!)
//        table_detailView?.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.view)
//            make.bottom.equalTo(self.view.snp.top).offset(-28)
//            make.height.equalTo(92)
//        }
        tableManager = TaskDetailTableManager()
    }

    func add_finsh_navigate() {
        view.addSubview(finshNavigate)
//        finshNavigate.snp.makeConstraints { (make) in
//            make.left.equalTo(view).offset(15)
//            make.bottom.equalTo(view).offset(-24)
//            make.height.equalTo(47)
//            make.width.equalTo(0)
//        }
        finshNavigate.handle(.touchUpInside) { (btn) in          //结束导航按钮
            self.addAnnotation(coors: self.tempDataArr)
            self.mapView?.setCenter(self.didSelected_annotation_index, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                for i in 0 ..< self.pinAnnotationArr.count {
                    if i == (self.selectAnnateView - 20000) {
                        let annotationView = self.pinAnnotationArr[i]
                        annotationView.image = UIImage(named: "icon_location_Charging_Point_pitch_on")
                    }
                }
            })
            self.planRouteShow(isShow: false)
            self.viewForm_bottom(form: .view_middle)
            self.showPlanRoute = true
        }
    }
    
    func add_navigate_btn() {
        view.addSubview(navigate_btn)
//        navigate_btn.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view).offset(14)
//            make.bottom.equalTo(self.location_btn.snp.top).offset(-12)
//            make.height.equalTo(40)
//            make.width.equalTo(0)
//        }
    }

    func add_location_btn() {
        location_btn.handle(UIControlEvents.touchUpInside) { (btn) in
            if self.p_user_location?.location.coordinate != nil {
                self.mapView?.setCenter((self.p_user_location?.location.coordinate)!, animated: true)
            }
        }
        location_btn.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(14)
            make.bottom.equalTo(self.view).offset(-89)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
    }
    
    func add_map_top_detailView() {
        self.view.addSubview(map_detailView)
        map_detailView.home_bottomView_detail?.frame.size = CGSize.zero
        map_detailView.backView?.frame.size = CGSize.zero;
        map_detailView.navigate_btnClicked = {(btn: UIButton ) -> Void in
//            let userInfo = UserInfoViewController()
//            self.navigationController?.pushViewController(userInfo, animated: true)
        }
    }
    
    func add_map_bottom_detailView() {
        self.view.addSubview(map_bottom_detailView)
        map_bottom_detailView.bottomView?.selectItem = {(type) -> Void in  //点击底部视图第一组事件回调
            self.map_bottom_detailView_mainEvent(type: type)
        }
        //点击底部视图第二组事件
        map_bottom_detailView.order_from_btn_type = {(type, parentIndex, isSeleted) ->Void in
            self.map_bottom_detailView_secondaryEvent(type: type, parentIndex: parentIndex, isSeleted: isSeleted)
        }
        map_bottom_detail_addPan()
    }
    
    //底部视图添加手势
    func map_bottom_detail_addPan()  {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(MapViewController.pan_map_bottom_detailView))
        pan.delegate = self
        map_bottom_detailView.addGestureRecognizer(pan)
    }
    
    func pan_map_bottom_detailView(_ pan: UIPanGestureRecognizer) {
        let point:CGPoint? = pan.translation(in: self.view)
        if pan.state == UIGestureRecognizerState.began {
            self.panTemp = point!.y
        }
        if pan.state == UIGestureRecognizerState.ended || pan.state == UIGestureRecognizerState.cancelled || pan.state == UIGestureRecognizerState.failed{
            if -point!.y > 60 || self.map_bottom_detailView.top <  SCREEN_HEIGHT - 100{   //上啦
                viewForm_bottom(form: .view_bottom)
                
            }
            if self.map_bottom_detailView.top < SCREEN_HEIGHT - 66 && self.map_bottom_detailView.top > SCREEN_HEIGHT - 100 || self.map_bottom_detailView.top > SCREEN_HEIGHT - 65{
                viewForm_bottom(form: .view_middle)
            }
        }
        if pan.state == UIGestureRecognizerState.changed {
            if self.map_bottom_detailView.top < SCREEN_HEIGHT - 140.5  {  //上啦
                return
            }
            self.map_bottom_detailView.top = self.map_bottom_detailView.top + point!.y - self.panTemp
            self.location_btn.bottom = self.map_bottom_detailView.top - 12
            self.panTemp = point!.y
        }
    }
    
    //    解决手势冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view == map_bottom_detailView.bottomView?.filter.handler{
            return false
        }
        return true
    }
    
    func congifTaskDetailTable(task: TaskModel) {
        if task_detailTable != nil {
            task_detailTable?.removeFromSuperview()
        }
        let height = OverhaulTool.calculateHeight(withTaskType: UInt(task.taskType))
        task_detailTable = TaskDetailTable.init(taskModel: task, tableWidth: height);
        task_detailTable?.buttonClickBlock = { (index) in
            if index == 0 { //去这里
                let route = BaiDuMap_drawRoute(map: self.mapView!)
                route?.routePlaning((self.p_user_location?.location.coordinate)!, distrubution: self.didSelected_annotation_index)
                route?.planRoute = {  //路线成功
                    self.showPlanRoute = false
                    self.task_detailTable?.hideDetail()
                    self.planRouteShow(isShow: true)
                    self.navigate_btn.handle(UIControlEvents.touchUpInside, with: { (btn) in
                        Nav_Third_Party_Map2().openNavagate(origin: (self.p_user_location?.location.coordinate)!, distination: self.didSelected_annotation_index)
                    })
                }
            }else if index == 1 {  //开始作业
                if task.taskType == 0 || task.taskType == 3{
                    task.taskType = 1
                    self.task_detailTable?.taskModel = task
                    
                }else {
                    switch self.taskType {
                    case .customService:      //客服
//                        self.navigationController?.pushViewController(ClientServeTaskViewController(), animated: true)
                        break
                    case .planRepair:   //检修
//                        let plan = PlanRepairViewController()
//                        plan.title = "检修单"
//                        self.navigationController?.pushViewController(plan, animated: true)
                        break
                    case .specialTour:   //特巡
//                        let plan = PlanRepairViewController()
//                        plan.title = "特巡单"
//                        self.navigationController?.pushViewController(plan, animated: true)
                        break
                    case .tour:   //巡视
//                        self.navigationController?.pushViewController(TourRepairVC(), animated: true)
                        break
                    case .failureTask:  //失败
                        switch self.failure {
                        case .sourceSpecialTour:   //特巡
//                            let plan = PlanRepairViewController()
//                            plan.title = "特巡单"
//                            self.navigationController?.pushViewController(plan, animated: true)
                            break
                        case .sourceCustomService:   //客服
//                            self.navigationController?.pushViewController(ClientServeTaskViewController(), animated: true)
                            break
                        default:
                            break
                        }
                        break
                    default:
                        break
                    }
                }
            }
        }
        
        table_detailView?.taskModel = task
        //详情显示控制
        task_detailTable?.hideOrShowBlock = {(isShow) in
            if !self.showPlanRoute {
                return
            }
            if isShow {
                self.viewForm_bottom(form: .view_top)
            }else {
                self.viewForm_bottom(form: .view_middle)
            }
        }
        self.view.addSubview(task_detailTable!)
        self.view.bringSubview(toFront: table_detailView!)
        task_detailTable?.frame = CGRect(x: 0, y: -height - 28, width: SCREEN_WIDTH, height: height + 28)
//        task_detailTable?.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self.view)
//            make.bottom.equalTo(self.view.snp.top).offset(0)
//            make.height.equalTo(height + 28)
//        }
        task_detailTable?.tableView.delegate = tableManager
        task_detailTable?.tableView.dataSource = tableManager
        task_detailTable?.tableView.estimatedRowHeight = 44
        task_detailTable?.tableView.rowHeight = UITableViewAutomaticDimension
        tableManager?.getTasksForTable(table_detailView?.tableView, taskModel: task)
    }
    
    func viewForm_bottom(form: Bottom_View_Show_Form) {
        switch form {
        case .view_top:
            UIView.animate(withDuration:animateTime, animations: {
                self.map_bottom_detailView.top = self.view.bottom
                self.location_btn.bottom = self.view.bottom - 12
            })
            hidden_top_detailView()
            break
        case .view_middle:
            UIView.animate(withDuration: animateTime, animations: { 
              self.map_bottom_detailView.top = self.view.bottom - 75
              self.location_btn.bottom = self.view.bottom - 89
            })
            show_top_detailView()
            break
        case .view_bottom:
            UIView.animate(withDuration: animateTime, animations: { 
                self.map_bottom_detailView.bottom = self.view.bottom
                self.location_btn.bottom = self.view.bottom - 152
            })
            hidden_top_detailView()
            break
        }
    }
    
    func display_tableView_detailView(_ isShow: Bool ) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            if isShow {
                UIView.animate(withDuration: self.animateTime, animations: {
                    self.table_detailView?.top = self.view.top
                    self.task_detailTable?.bottom = 120
                })
            } else {
                UIView.animate(withDuration: self.animateTime, animations: {
                    self.table_detailView?.bottom = self.view.top - 28
                    self.task_detailTable?.bottom = 0
                })
            }
        }
    }
    
    func hidden_top_detailView() {
        UIView.animate(withDuration: animateTime, animations: {
            self.map_detailView.backView?.height = 1.0
            self.map_detailView.home_bottomView_detail?.height = 1.0
        }) { (complete) in
            UIView.animate(withDuration: self.animateTime, animations: {
                self.map_detailView.backView?.width = 0
                self.map_detailView.home_bottomView_detail?.width = 0
            })
        }
    }
    
    func show_top_detailView() {
        if isShow_top_detailView {
            UIView.animate(withDuration: animateTime, animations: {
                self.map_detailView.backView?.width = 47.5
                self.map_detailView.home_bottomView_detail?.width = SCREEN_WIDTH - 31
            }) { (complete) in
                UIView.animate(withDuration: self.animateTime, animations: {
                    self.map_detailView.backView?.height = 44.5
                    self.map_detailView.home_bottomView_detail?.height = 44.5
                })
            }
        }
    }
    
    func planRouteShow(isShow: Bool) {
        if isShow {
            finshNavigate.isHidden = false
            navigate_btn.isHidden = false
            map_bottom_detailView.isHidden = true
            location_btn.bottom = SCREEN_HEIGHT - 89
            UIView.animate(withDuration: animateTime, animations: {
                self.navigate_btn.width = 40
                self.finshNavigate.width = SCREEN_WIDTH - 30
            })
        } else {
            map_bottom_detailView.isHidden = false
            UIView.animate(withDuration: animateTime, animations: {
                self.navigate_btn.width = 0
                self.finshNavigate.right = 0
            })
        }
    }
    
    //第一组事件
    func map_bottom_detailView_mainEvent(type: EItemType) {
        isShow_top_detailView = false
        hidden_top_detailView()
        navigate_btn.isHidden = true
        pinAnnotationArr.removeAll()
        index = 0
        self.dataArr.removeAll()
        self.map_zoom = true
        taskType = type
        isNumArr = true
        display_tableView_detailView(false)
        switch type {
        case .customService: //客服
            self.dataArr = self.first_dataArr
            break;
        case .planRepair:  //检修
            self.dataArr = self.secong_dataArr
            break
        case .specialTour:  //特巡
            self.dataArr = self.third_dataArr
            break
        case .tour:  //巡视
            self.dataArr = self.fouth_dataArr
            break
        case .failureTask: //失败
            self.dataArr = self.five_dataArr
            break
        default:
            break
        }
        self.showAnnotation()
    }
    //第二组事件
    func map_bottom_detailView_secondaryEvent(type: EFilterType, parentIndex: EItemType, isSeleted: Bool) {
        display_tableView_detailView(false)
        isShow_top_detailView = isSeleted
        hidden_top_detailView()
        pinAnnotationArr.removeAll()
        index = 0
        navigate_btn.isHidden = true
        isNumArr = false
        failure = type
        if (self.mapView?.annotations.count)! > 0 {
            self.mapView?.removeAnnotations(self.mapView?.annotations)
        }
        self.map_zoom = true
        if isSeleted == false {
            map_bottom_detailView_mainEvent(type: parentIndex)
            return
        }
        var datailStr = String()
        var dataCoors = [TaskModel]()
        switch parentIndex {
        case .customService:  //客服
            switch type {
            case .source95598:
                dataCoors = self.dataArr[0]
                datailStr = "工单来源: 95598"
                break
            case .sourceOther:
                dataCoors = self.dataArr[1]
                datailStr = "工单来源: 其他来源"
                break
            case .sourceUnConfirm:
                dataCoors = self.dataArr[2]
                datailStr = "工单来源: 未确认"
                break
            default:
                break
            }
            break
        case .planRepair:     //检修
            switch type {
            case .sourceSystem:
                dataCoors = self.dataArr[0]
                datailStr = "工单来源: 平台检测"
                break
            case .sourceTour:
                dataCoors = self.dataArr[1]
                datailStr = "工单来源: 巡视报修"
                break
            default:
                break
            }
            break
        case .specialTour:   //特巡
            switch type {
            case .sourceSystem:
                dataCoors = self.dataArr[0]
                datailStr = "工单来源: 平台检测"
                break
            case .sourceOther:
                dataCoors = self.dataArr[1]
                datailStr = "工单来源: 其他来源"
                break
            case .sourceUnConfirm:
                dataCoors = self.dataArr[2]
                datailStr = "工单来源: 未确认"
                break
            default:
                break
            }
            break
        case .tour:       //巡视
            
            break
        case .failureTask:     //失败
            switch type {
            case .sourceCustomService:
                dataCoors = self.dataArr[0]
                datailStr = "工单来源: 客户"
                break
            case .sourceSpecialTour:
                dataCoors = self.dataArr[1]
                datailStr = "工单来源: 特巡"

                break
            default:
                break
            }
            break
        default:
            break
        }  
        self.secondary_btnSeleted(coors: dataCoors, detaiStr: datailStr)
    }
    
    func showAnnotation() {
        firstArr.removeAll()
        var tempArr = [CLLocationCoordinate2D]()
        for i in 0 ..< dataArr.count {
            let arr = dataArr[i]
            for j in 0 ..< arr.count {
                let model = arr[j]
                firstArr.append(model)
                tempArr.append(CLLocationCoordinate2D.init(latitude: model.latitude, longitude: model.longitude))
            }
        }
        tempDataArr = tempArr
        addAnnotation(coors: tempArr)
    }

    func secondary_btnSeleted(coors: [TaskModel] ,detaiStr: String) {
        secondArr.removeAll()
        var coorData = [CLLocationCoordinate2D]()
        for i in 0 ..< coors.count {
            let model = coors[i]
            secondArr.append(model)
            coorData.append(CLLocationCoordinate2D.init(latitude: model.latitude, longitude:model.longitude))
        }
        tempDataArr = coorData
        self.addAnnotation(coors: coorData )
        self.map_detailView.backView?.text = String((coors as AnyObject).count)
        self.map_detailView.home_bottomView_detail?.text = detaiStr
    }
    
    
    
}
