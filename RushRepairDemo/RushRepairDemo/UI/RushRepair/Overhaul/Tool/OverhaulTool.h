//
//  OverhaulTool.h
//  IOVS
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OverhaulTool : NSObject

/**
 根据工单状态计算工单高度

 @param taskType 工单状态

 @return 工单高度
 */
+(CGFloat)calculateHeightWithTaskType:(NSUInteger)taskType;
@end
