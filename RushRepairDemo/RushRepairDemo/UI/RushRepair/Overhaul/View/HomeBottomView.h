//
//  HomeBottomView.h
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEFilterControl.h"

@interface HomeBottomView : UIView
@property (nonatomic, copy) SEFilterControl *filter;
@property (nonatomic, copy) void(^FilterBlock)(EFilterType btnTag, EItemType parentIndex, BOOL isSelected);
@property (nonatomic, copy) void(^SelectItem)(EItemType itemType);

//刷新筛选试图
-(void)reloadFilterViewWithSelectedIndex:(NSUInteger)index;

@end
