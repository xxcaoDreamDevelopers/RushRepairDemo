//
//  TaskDetailTable.h
//  IOVS
//
//  Created by UPBest_iOS_1 on 16/9/30.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskModel;
@interface TaskDetailTable : UIView
@property (nonatomic, strong) UITableView *tableView;
-(instancetype)initWithTaskModel:(TaskModel *)taskModel tableWidth:(CGFloat)tableWidth;

//按钮点击事件 0 去这里 1 开始作业
@property (nonatomic, copy) void (^ButtonClickBlock)(NSUInteger tag);


//展开或者隐藏工单详情
@property (nonatomic, copy) void (^HideOrShowBlock)(BOOL show);


@property (nonatomic, strong) TaskModel *taskModel;
-(void)hideDetail;
@end
