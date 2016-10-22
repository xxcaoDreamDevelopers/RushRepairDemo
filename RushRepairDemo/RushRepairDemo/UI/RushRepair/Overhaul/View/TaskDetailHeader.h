//
//  TaskDetailHeader.h
//  IOVS
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDetailHeader : UIView
-(instancetype)initWithTaskType:(NSUInteger)taskType deviceType:(NSUInteger)deviceType;
@property (nonatomic, assign) NSUInteger taskType;//工单状态
@property (nonatomic, assign) NSUInteger deviceType;//设备类型
@end
