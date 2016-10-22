//
//  TaskFilterView.h
//  IOVS
//
//  Created by Dale on 16/9/23.
//  Copyright © 2016年 AKASHA. All rights reserved.
//  分类工单

#import <UIKit/UIKit.h>



@interface TaskFilterView : UIView
-(void)refreshBtns;
@property (nonatomic, copy) void(^myBlock)(NSUInteger btnTag, NSUInteger parentIndex, BOOL isSelected);
 //筛选按钮标题
@property (nonatomic, strong) NSArray *filterTitles;

//父级编号
@property(nonatomic, assign) NSUInteger parentIndex;

@property (nonatomic, strong) UIButton *unConfirmBtn; //未确认按钮

@end
