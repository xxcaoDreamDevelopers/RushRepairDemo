//
//  TaskDetailView.m
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskDetailView.h"
#import "TaskDetailTableManager.h"
#import "TaskDetailFooter.h"
#import "NewTaskDetailFooter.h"
#import "UIColor+HEX.h"
@interface TaskDetailView()
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) UIButton *showOrHideBtn;
@property (nonatomic, strong) UIView *sumDesc;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UILabel *contentLab;
@property (nonatomic, strong) UILabel *distanceLab;
@end
@implementation TaskDetailView

-(instancetype)initWithIsNewTask:(BOOL)isNewTask{
    if (self = [super init]) {
        
        
        _isShow = NO;
        UIView *sumDesc = [[UIView alloc] init];
        [self addSubview:sumDesc];
        [sumDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.equalTo(@92);
        }];
        _sumDesc = sumDesc;
        
        //电桩地址
        UILabel *sumLabel = [[UILabel alloc]init];
        sumLabel.font = [UIFont systemFontOfSize:20.0];
        sumLabel.textColor = [UIColor whiteColor];
        sumLabel.text = @"三里屯购物中心停车场";
        [sumDesc addSubview:sumLabel];
        [sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sumDesc).offset(15);
            make.top.equalTo(sumDesc).offset(30);
        }];
        self.contentLab = sumLabel;
        //电桩
        UILabel *addLabel = [[UILabel alloc]init];
        addLabel.textColor = [UIColor colorWithHexString:@"d0e3db"];
        addLabel.font = [UIFont systemFontOfSize:15.0];
        addLabel.text = @"电话报修 - 充电桩电源连接却无法充电";
        [sumDesc addSubview:addLabel];
        [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(sumLabel);
            make.bottom.equalTo(sumDesc.mas_bottom).offset(-13);
        }];
        self.addressLab = addLabel;
        //
        //距离
        UILabel *distanceLabel = [[UILabel alloc] init];
        distanceLabel.text = @"1.3公里";
        distanceLabel.textColor = [UIColor colorWithHexString:@"d4bb54"];
        distanceLabel.font = [UIFont systemFontOfSize:15.0];
        [sumDesc addSubview:distanceLabel];
        [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(sumLabel);
            make.right.equalTo(self).offset(-15);
        }];
        self.distanceLab = distanceLabel;

    
        sumDesc.backgroundColor = [UIColor colorWithHexString:@"2f9771"];

        
        

        

        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        

        
   

        
    }
    return self;
}



-(void)refreshDetaiView{
    _isShow = NO;
    _isShow ? [_showOrHideBtn setImage:[UIImage imageNamed:@"icon_pack_up"] forState:UIControlStateNormal]: [_showOrHideBtn setImage:[UIImage imageNamed:@"icon_drop_down"] forState:UIControlStateNormal];
}

#pragma mark - 
-(void)tap{
    NSLog(@"tap");
}

-(void)layoutSubviews{
    [super layoutSubviews];
//    _tableView.frame = CGRectMake(0, 90, self.frame.size.width, 400);
}



-(void)setTaskModel:(TaskModel *)taskModel{
    _taskModel = taskModel;
    
    NSString *source = @"";
    switch (taskModel.taskSource) {
        case EFilterTypeSourceSystem:
            source = @"平台监测";
            break;
        case EFilterTypeSourceTour:
            source = @"巡视报修";
            break;
        case EFilterTypeSource95598:
            source = @"95598报修";
            break;
        case EFilterTypeSourceOther:
            source = @"400报修";
            break;
        case EFilterTypeSourceNormalTour:
            source = @"正常巡视";
            
        default:
            break;
    }
    self.addressLab.text = taskModel.address;
    self.contentLab.text = source;
    //计算距离
    self.distanceLab.text = @"5公里";
    
}

@end















