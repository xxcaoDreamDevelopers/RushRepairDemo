//
//  TaskDetailTableManager.m
//  IOVS
//
//  Created by Dale on 16/9/26.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

//
//  CollectingTableManager.m
//  MPP
//
//  Created by UPBest_iOS_1 on 16/7/8.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "TaskDetailTableManager.h"
#import "TaskDetailCell.h"
#import "TaskDetailModel.h"
#import "BlockUI.h"
#import "TaskDetailFooter.h"
#import "TaskDetailHeader.h"
#define COLLECTING_PAGE_SIZE 10

@interface TaskDetailTableManager ()<UIAlertViewDelegate>{
    NSUInteger _taskItem;
}

@property (nonatomic, strong) UINib *nibcell;
@property (nonatomic, strong) NSMutableDictionary *testDic;

@property (nonatomic, assign) int initPage;

@property (nonatomic, assign) BOOL isNeedUpPullRefresh;

@property (nonatomic, strong) NSMutableArray *tasksArr;

@property (nonatomic, strong) NSMutableArray *waitArr;

@property (nonatomic, strong) NSMutableArray *doneArr;

@property (nonatomic, strong) UITableView *tableV;

@property (nonatomic, strong) NSString *url_type;
@end

@implementation TaskDetailTableManager

#pragma mark - lifeCycle
-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}


#pragma mark - delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detail"];
    if (cell == nil) {
        cell = LoadFromNib(@"TaskDetailCell");
    }
    cell.detailModel = self.dataSource[indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}





#pragma mark - UITableViewDelegate

 -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"%d",(int)indexPath.row);
     
     if (_taskItem == EItemTypeCustomService || _taskItem == EItemTypePlanRepair) {//客服、检修
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
         
         TaskDetailModel *detailModel = self.dataSource[indexPath.row];
         if (indexPath.row == 2) {//电话
             
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"186xxxx6979" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
             [alert show];
             
             if (self.didSelectBlock) {
                 self.didSelectBlock(self,detailModel.detail);
             }
         }
         
     }
     
 
 }


//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 66;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 102;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return [[TaskDetailFooter alloc]init];
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    return [[TaskDetailHeader alloc]init];
//}
#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}

#pragma mark - Private Method

-(void)getTasksForTable:(UITableView *)table taskModel:(TaskModel *)taskModel{
    self.tableV = table;
    [self downloadTaskDetailWithTableView:table taskModel:taskModel];
}

-(void)reloadTasks:(id)task{
    self.dataSource = task;
    [self.tableV reloadData];
}



/**
 *  请求数据
 */
-(void)downloadTaskDetailWithTableView:(UITableView *)tableView taskModel:(TaskModel *)taskModel{
    _taskItem = taskModel.taskItemType;
    if (taskModel.taskItemType == EItemTypeSpecialTour || taskModel.taskItemType == EItemTypeTour) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        TaskDetailModel *detailMode3 = [[TaskDetailModel alloc] init];
        detailMode3.desc = @"派发时间:";
        detailMode3.detail = taskModel.distributeTime;
        detailMode3.icon = @"icon_time";
        detailMode3.isHidden = YES;
        [tempArray addObject:detailMode3];
        
        TaskDetailModel *detailMode4 = [[TaskDetailModel alloc] init];
        detailMode4.desc = @"巡视频率:";
        detailMode4.detail = taskModel.tourFrequence;
        detailMode4.icon = @"icon_frequency";
        detailMode4.isHidden = YES;
        [tempArray addObject:detailMode4];
        
        TaskDetailModel *detailMode5 = [[TaskDetailModel alloc] init];
        if (taskModel.taskItemType == EItemTypeSpecialTour) {
            detailMode5.desc = @"开始时间:";

        }else {
            detailMode5.desc = @"本期起始:";
        
        }
        detailMode5.detail = taskModel.startTime;
        detailMode5.icon = @"icon_date";
        detailMode5.isHidden = YES;
        [tempArray addObject:detailMode5];
        
        
        TaskDetailModel *detailMode7 = [[TaskDetailModel alloc] init];
        
        if (taskModel.taskItemType == EItemTypeSpecialTour) {
            detailMode7.desc = @"结束时间:";
            
        }else {
            detailMode7.desc = @"本期结束:";
            
        }
        detailMode7.detail = taskModel.endTime;
//        detailMode7.icon = @"icon_serial_number";
        detailMode7.isHidden = YES;
        [tempArray addObject:detailMode7];
        
        TaskDetailModel *detailMode8 = [[TaskDetailModel alloc] init];
        detailMode8.desc = @"巡视内容:";
        if (taskModel.taskItemType == EItemTypeTour) {
            detailMode8.detail = @"--";
        }else {
            detailMode8.detail = taskModel.faultContent;
        }
        detailMode8.icon = @"icon_content";
        detailMode8.isHidden = YES;
        [tempArray addObject:detailMode8];
        
        TaskDetailModel *detailMode9 = [[TaskDetailModel alloc] init];
        detailMode9.desc = @"巡视意见:";
        if (taskModel.taskItemType == EItemTypeTour) {
            detailMode9.detail = @"--";
        }else {
            detailMode9.detail = taskModel.faultContent;
        }
        detailMode9.icon = @"icon_advice";
        detailMode9.isHidden = YES;
        [tempArray addObject:detailMode9];

        
        
        self.tasksArr = [NSMutableArray arrayWithArray:tempArray];
        [self reloadTasks:self.tasksArr];
        
    }else {
        NSMutableArray *tempArray = [NSMutableArray array];
        TaskDetailModel *detailMode3 = [[TaskDetailModel alloc] init];
        detailMode3.desc = @"派发时间:";
        detailMode3.detail = taskModel.distributeTime;
        detailMode3.icon = @"icon_time";
        detailMode3.isHidden = YES;
        [tempArray addObject:detailMode3];
        
        TaskDetailModel *detailMode4 = [[TaskDetailModel alloc] init];
        detailMode4.desc = @"任务周期:";
        detailMode4.detail = taskModel.taskCycle;
        detailMode4.icon = @"icon_cycle";
        detailMode4.isHidden = YES;
        [tempArray addObject:detailMode4];
        
        TaskDetailModel *detailMode5 = [[TaskDetailModel alloc] init];
        detailMode5.desc = @"报修人员:";
        detailMode5.detail = taskModel.repairMan;
        detailMode5.icon = @"icon_repair_man";
        detailMode5.isHidden = NO;
        [tempArray addObject:detailMode5];
        
        
        TaskDetailModel *detailMode7 = [[TaskDetailModel alloc] init];
        detailMode7.desc = @"运行编号:";
        detailMode7.detail = taskModel.taskNumber;
        detailMode7.icon = @"icon_serial_number";
        detailMode7.isHidden = YES;
        [tempArray addObject:detailMode7];
        
        TaskDetailModel *detailMode8 = [[TaskDetailModel alloc] init];
        detailMode8.desc = @"故障描述:";
        detailMode8.detail = taskModel.faultContent;
        detailMode8.icon = @"icon_content";
        detailMode8.isHidden = YES;
        [tempArray addObject:detailMode8];
        
        TaskDetailModel *detailMode9 = [[TaskDetailModel alloc] init];
        detailMode9.desc = @"处理意见:";
        //    detailMode7.detail = @"GZHD-0014";
        detailMode9.detail = taskModel.advice;
        detailMode9.icon = @"icon_advice";
        detailMode9.isHidden = YES;
        [tempArray addObject:detailMode9];
        
        
        self.tasksArr = [NSMutableArray arrayWithArray:tempArray];
        [self reloadTasks:self.tasksArr];
    
    }
    
    
    

}


#pragma mark - setter/getter
-(NSMutableArray *)tasksArr{
    if (_tasksArr == nil) {
        _tasksArr = [NSMutableArray array];
    }
    return _tasksArr;
}

-(NSArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


@end






















