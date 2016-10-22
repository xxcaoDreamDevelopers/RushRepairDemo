//
//  TestVC.m
//  IOVS
//
//  Created by Dale on 16/9/22.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TestVC.h"
#import "SEFilterControl.h"
#import "TaskFilterView.h"
#import "HomeBottomView.h"
#import "TaskDetailView.h"
#import "TaskDetailTableManager.h"
#import "TaskDetailModel.h"
#import "TaskDetailTable.h"
#import "OverhaulTool.h"
//#import "ForwardTaskVC.h"
@interface TestVC ()
@property(nonatomic, strong) SEFilterControl *filter;
@property(nonatomic, strong) TaskDetailView *detailView;
@property(nonatomic, strong) TaskDetailTableManager<UITableViewDataSource,UITableViewDelegate> *tableManager;
@property(nonatomic, strong) HomeBottomView *bottomView;
@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    
    backItem.title = @"返回";
    
    self.navigationItem.backBarButtonItem = backItem;
    

    HomeBottomView *bottomView = [[HomeBottomView alloc]init];
    bottomView.SelectItem = ^(EItemType itemType){
        
        switch (itemType) {
            case EItemTypeTemporaryRepair:
                NSLog(@"--EItemTypeTemporaryRepair");
                break;
            case EItemTypePlanRepair:
                NSLog(@"--EItemTypePlanRepair");
                break;
            case EItemTypeTour:
                NSLog(@"--EItemTypeTour");
                break;
            case EItemTypeFailureTask:
                NSLog(@"--EItemTypeFailureTask");
                break;
                
            default:
                
                break;
        }

        
    };
    
    
    bottomView.FilterBlock = ^(EFilterType filterType,EItemType parentIndex, BOOL isSelected){
        NSLog(@"%d",isSelected);
        switch (parentIndex) {
            case 0:{
                switch (filterType) {
                    case EFilterTypeSourceTelphone:
                        NSLog(@"EFilterTypeSourceTelphone");
                        break;
                    case EFilterTypeSourceSystem:
                        NSLog(@"EFilterTypeSourceSystem");
                        break;
                    case EFilterTypeSourceTour:
                        NSLog(@"EFilterTypeSourceTour");
                        break;
                    case EFilterTypeSourceUnConfirm:
                        NSLog(@"EFilterTypeSourceUnConfirm");
                        break;
                    default:
                        break;
                }
            }
                
                break;
            case 1:{
                switch (filterType) {
                    case EFilterTypeSourceSystem:
                        NSLog(@"EFilterTypeSourceSystem");
                        break;
                    case EFilterTypeSourceTour:
                        NSLog(@"EFilterTypeSourceTour");
                        break;
                    case EFilterTypeSourceUnConfirm:
                        NSLog(@"EFilterTypeSourceUnConfirm");
                        break;
                    default:
                        break;
                }
            }
                
                break;
            case EItemTypeTour:{
                switch (filterType) {
                    case EFilterTypeSourceNormalTour:
                        NSLog(@"EFilterTypeSourceNormalTour");
                        break;
                    case EFilterTypeSourceSpecialTour:
                        NSLog(@"EFilterTypeSourceSpecialTour");
                        break;
                    case EFilterTypeSourceUnConfirm:
                        NSLog(@"EFilterTypeSourceUnConfirm");
                        break;
                    default:
                        break;
                }
            }
        
                break;
//            case EFilterTypeSourceUnConfirm:{
//                switch (filterType) {
//                    case EFilterTypeSourceTemporaryRepair:
//                        NSLog(@"EFilterTypeSourceTemporaryRepair");
//                        break;
//                    case EFilterTypeSourcePlanRepair:
//                        NSLog(@"EFilterTypeSourcePlanRepair");
//                        break;
//                    default:
//                        break;
//                }
//            }
                
                break;
                
            default:
                
                break;
        }
    };
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    self.bottomView = bottomView;
    
    TaskDetailView *detailView = [[TaskDetailView alloc]initWithIsNewTask:NO];
//    detailView.ShowHideBlock = ^(BOOL isShow){
//        isShow ?
//        
//        [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@500);
//        }]:     [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(@95);
//            
//        }];
//
//    };
    detailView.clipsToBounds = YES;
    
//    UIButton *button = [[UIButton alloc]init];
//    [button setTitle:@"点我" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
    detailView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:detailView];
    [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@92);
    }];
    self.detailView = detailView;
    
    
    TaskModel *task = [[TaskModel alloc]init];
    task.distributeTime = @"2016-10-06 09:40";
    task.taskCycle = @"3天";
    task.repairMan = @"李金羽";
    task.taskNumber = @"GZHD--0014";
    task.advice = @"请尽快解决";
    task.deviceType = EDeviceTypeDC;
    task.taskItemType = EItemTypeSpecialTour;
    task.taskType = ETaskTypeFailure;
    task.faultContent = @"充电桩电源接头损坏";
    task.address = @"前门大街2号";
    task.tourFrequence = @"1次／1天";
    task.startTime = @"2016-10-17 09:00";
    task.endTime = @"2016-10-18 09:00";
    task.taskSource = EFilterTypeSourceOther;

    
    detailView.taskModel = task;
    CGFloat height = [OverhaulTool calculateHeightWithTaskType:task.taskType];
    TaskDetailTable *detailTable = [[TaskDetailTable alloc]initWithTaskModel:task tableWidth:height];
    [self.view addSubview:detailTable];
    __weak typeof(detailTable) weakDetailTable = detailTable;
    detailTable.ButtonClickBlock = ^(NSUInteger tag){
        NSLog(@"%d",(int)tag);
        if (tag == 0) { //去这里
        }
        if (tag == 1 && (task.taskType == ETaskTypeUnreceive || task.taskType == ETaskTypeFailure)) { // 领取工单
            task.taskType = ETaskTypeUndo;
            weakDetailTable.taskModel = task;
        }else if (tag == 1 && task.taskType == ETaskTypeUndo) {// 填写工单
//            TourRepairVC *tour = [[TourRepairVC alloc]init];
//            [self.navigationController pushViewController:tour animated:YES];
            
//            ForwardTaskVC *forwardVC = [[ForwardTaskVC alloc]init];
//            [self.navigationController pushViewController:forwardVC animated:YES];
        }
    };
    detailTable.HideOrShowBlock = ^(BOOL show){
        if (show == YES) {
            NSLog(@"请隐藏底部");
        }
        else {
            NSLog(@"请显示底部");
        }
    };
    [detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(detailView.mas_bottom).offset(28);
        make.height.equalTo(@(height + 28));
    }];
    detailTable.tableView.dataSource = self.tableManager;
    detailTable.tableView.delegate = self.tableManager;
    detailTable.tableView.estimatedRowHeight = 44;
    detailTable.tableView.rowHeight = UITableViewAutomaticDimension;
 
    [self.tableManager getTasksForTable:detailTable.tableView taskModel:task];

    [self.view bringSubviewToFront:detailView];
}


#pragma mark -- 点击底部按钮响应事件
-(void)filterValueChanged:(SEFilterControl *)sender
{
    NSLog(@"当前滑块位置%d",sender.SelectedIndex);
    //    switch (sender.SelectedIndex) {
    //        case 0:
    //            _showLabel.text = @"当前选中的是：人民轿车";
    //            break;
    //        case 1:
    //            _showLabel.text = @"当前选中的是：高级轿车";
    //            break;
    //        case 2:
    //            _showLabel.text = @"当前选中的是：豪华轿车";
    //            break;
    //        case 3:
    //            _showLabel.text = @"当前选中的是：优步专车";
    //            break;
    //        default:
    //            break;
    //    }
    [self.bottomView reloadFilterViewWithSelectedIndex:sender.SelectedIndex];
    
}
//
//-(void) click{
//    [_detailView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@500);
//    }];
//
//}

-(TaskDetailTableManager *)tableManager{
    if (_tableManager == nil) {
        _tableManager = [[TaskDetailTableManager alloc]init];
    }
    return _tableManager;
}

-(void)test:(SEFilterControl *)se{
    NSLog(@"%d",se.SelectedIndex);
}

//-(CGFloat)calculateHeightWithTaskType:(NSUInteger)taskType{
//    CGFloat height = 0.0;
//    switch (taskType) {
//        case ETaskTypeUnreceive:
//            height = 382;
//            if (is40inch) {
//                height -= 12;
//            }
//            break;
//            
//        case ETaskTypeUndo:
//            height = 382;
//            if (is40inch) {
//                height -= 12;
//            }
//            break;
//            
//        case ETaskTypeUnConfirm:
//            height = 323;
//            if (is40inch) {
//                height -= 12;
//            }
//            break;
//            
//        case ETaskTypeFailure:
//            height = 323;
//            if (is40inch) {
//                height -= 12;
//            }
//            break;
//            
//        default:
//            break;
//    }
//    
//    
//    return height;
//}

@end






