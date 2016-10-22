//
//  NewTaskDetailFooter.h
//  IOVS
//
//  Created by Dale on 16/9/27.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTaskDetailFooter : UIView
@property (nonatomic, copy) void (^ButtonClickBlock)(NSUInteger tag);
@end
