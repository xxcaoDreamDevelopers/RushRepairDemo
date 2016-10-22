//
//  TaskDetailCell.h
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TaskDetailModel;
@interface TaskDetailCell : UITableViewCell
@property (nonatomic, strong) TaskDetailModel *detailModel;
@end
