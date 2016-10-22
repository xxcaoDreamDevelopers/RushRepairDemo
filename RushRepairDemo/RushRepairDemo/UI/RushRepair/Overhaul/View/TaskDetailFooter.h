//
//  TaskDetailFooter.h
//  IOVS
//
//  Created by Dale on 16/9/27.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskDetailFooter : UIView

@property (nonatomic, copy) void (^ButtonClickBlock)(NSUInteger tag);
@end
