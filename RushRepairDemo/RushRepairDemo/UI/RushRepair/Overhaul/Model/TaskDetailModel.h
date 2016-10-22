//
//  TaskDetailModel.h
//  IOVS
//
//  Created by Dale on 16/9/26.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, assign) BOOL isHidden;
@property (nonatomic, copy) NSString *taskTypeColor;
@end
