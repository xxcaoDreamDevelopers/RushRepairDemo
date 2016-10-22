//
//  TaskDetailHeader.m
//  IOVS
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskDetailHeader.h"
#import "TopCellView.h"
#import "TaskDetailModel.h"
@interface TaskDetailHeader()
@property (nonatomic, strong) TopCellView *cellView;
@end
@implementation TaskDetailHeader

-(instancetype)initWithTaskType:(NSUInteger)taskType deviceType:(NSUInteger)deviceType{
    if (self = [super init]) {
        for (int index = 0; index < 2; index ++) {
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [Common colorFromHexRGB:@"e3e3e3"];
            [self addSubview:view];
            setViewBorder(view, minLineWidth)
            setViewCorner(view, 3);
            
            TopCellView *top = [[TopCellView alloc]init];
            
            [view addSubview:top];
            [top mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.bottom.equalTo(view);
            }];
            if (index == 0) {
                _cellView = top;
            }
            
            if (index == 0) {
                TaskDetailModel *model = [[TaskDetailModel alloc]init];
                model.desc = @"工单状态";
                switch (taskType) {
                    case ETaskTypeUnreceive:
                        model.detail = @"未领取";
                        model.icon = @"icon_unreceive";
                        model.taskTypeColor = @"ef483b";
                        break;
                    case ETaskTypeUndo:
                        model.detail = @"已领取未执行";
                        model.icon = @"icon_undo";
                        model.taskTypeColor = @"ff8c01";
                        break;
                    case ETaskTypeUnConfirm:
                        model.detail = @"已提交未确认";
                        model.icon = @"icon_unconfirm";
                        model.taskTypeColor = @"ff8c01";
                        break;
                    case ETaskTypeFailure:
                        model.detail = @"失败";
                        model.icon = @"icon_failure";
                        model.taskTypeColor = @"ef483b";
                        break;
                        
                    default:
                        break;
                }
                
                top.detailModel = model;
            }else {
                TaskDetailModel *model = [[TaskDetailModel alloc]init];
                model.desc = @"设备类型";
                model.icon = @"icon_current";
                switch (deviceType) {
                    case EDeviceTypeAC:
                        model.detail = @"交流充电桩";
                        break;
                    case EDeviceTypeDC:
                        model.detail = @"直流充电桩";
                        break;
                        
                    default:
                        break;
                }
                
                top.detailModel = model;
                
            }
        }

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
     }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewX;
    CGFloat viewY = 17;
    CGFloat viewH;
    CGFloat margin;
    if (is40inch) {
        viewH = 70;
        margin = 15;
    }else {
        viewH = 75;
        margin = 20;
    }
    CGFloat viewW = (self.frame.size.width - 8 - margin * 2) / 2;
    for (int index = 0; index < self.subviews.count; index ++) {
    
        viewX = index * (viewW + 8) + margin;
        UIView *view = self.subviews[index];
        view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

-(void)setTaskType:(NSUInteger)taskType{
    _taskType = taskType;
    TaskDetailModel *model = [[TaskDetailModel alloc]init];
    model.desc = @"工单状态";
    switch (taskType) {
        case ETaskTypeUnreceive:
            model.detail = @"未领取";
            model.icon = @"icon_unreceive";
            model.taskTypeColor = @"ef483b";
            break;
        case ETaskTypeUndo:
            model.detail = @"已领取未执行";
            model.icon = @"icon_undo";
            model.taskTypeColor = @"ff8c01";
            break;
        case ETaskTypeUnConfirm:
            model.detail = @"已提交未确认";
            model.icon = @"icon_unconfirm";
            model.taskTypeColor = @"ff8c01";
            break;
        case ETaskTypeFailure:
            model.detail = @"失败";
            model.icon = @"icon_failure";
            model.taskTypeColor = @"ef483b";
            break;
            
        default:
            break;
    }
    
    _cellView.detailModel = model;

}


@end








