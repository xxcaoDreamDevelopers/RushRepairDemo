//
//  TaskDetailView.h
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
@interface TaskDetailView : UIView
//@property (nonatomic, copy) void(^ShowHideBlock)(BOOL isShow);
@property (nonatomic, strong) UITableView *tableView;
-(void)refreshDetaiView;
@property (assign, nonatomic) BOOL isNewTask;
-(instancetype)initWithIsNewTask:(BOOL)isNewTask;
@property (nonatomic, strong) TaskModel *taskModel;
@end
