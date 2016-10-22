//
//  OverhaulTool.m
//  IOVS
//
//  Created by mac on 16/10/18.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "OverhaulTool.h"
@implementation OverhaulTool
+(CGFloat)calculateHeightWithTaskType:(NSUInteger)taskType{
    CGFloat height = 0.0;
    switch (taskType) {
        case ETaskTypeUnreceive:
            height = 432;
            if (is40inch) {
                height -= 12;
            }
            break;
            
        case ETaskTypeUndo:
            height = 432;
            if (is40inch) {
                height -= 12;
            }
            break;
            
        case ETaskTypeUnConfirm:
            height = 373;
            if (is40inch) {
                height -= 12;
            }
            break;
            
        case ETaskTypeFailure:
            height = 432;
            if (is40inch) {
                height -= 12;
            }
            break;
            
        default:
            break;
    }
    
    
    return height;
}
@end
