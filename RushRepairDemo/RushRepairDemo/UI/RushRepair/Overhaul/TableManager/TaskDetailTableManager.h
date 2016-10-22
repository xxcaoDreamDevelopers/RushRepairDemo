//
//  TaskDetailTableManager.h
//  IOVS
//
//  Created by Dale on 16/9/26.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskModel.h"
@class TaskDetailTableManager;

typedef void(^TaskDetailDidSelectBlock)(TaskDetailTableManager *taskManager, id object);
typedef void(^TaskDetailEditActionsBlock)(TaskDetailTableManager *taskManager, id object);


@interface TaskDetailTableManager : NSObject<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *dataSource;
@property(nonatomic, copy) TaskDetailDidSelectBlock didSelectBlock;

@property(nonatomic, copy) TaskDetailEditActionsBlock editActionsBlock;

//@property (nonatomic ,copy) void(^hiddenView)();


-(void)getTasksForTable:(UITableView *)table taskModel:(TaskModel *)taskModel;



-(void)reloadTasks:(id)task;
@end
