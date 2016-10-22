//
//  PopTaskView.m
//  IOVS
//
//  Created by Dale on 16/9/22.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "PopTaskView.h"
#import "TestVC.h"
#import "RushRepairDemo-Swift.h"
@interface PopTaskView(){
    int _secondsCountDown;
}
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIButton *rejectBtn;
@property (strong, nonatomic) UIButton *takeBtn;
//接单倒计时
@property (nonatomic, strong) NSTimer *takeTaskTimer;
@end
@implementation PopTaskView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _secondsCountDown = 5;
        self.takeTaskTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
        
        //1.工单内容
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(125);
            make.left.equalTo(self).offset(36);
            make.right.equalTo(self).offset(-36);
            make.height.equalTo(@300);
        }];
        
        //1.2创建工单内容子项目
        [self createContentSubView];
        
        //2.拒绝按钮
        [self addSubview:self.rejectBtn];
        [self.rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(20);
            make.left.equalTo(self.contentView);
            make.width.equalTo(@80);
            make.height.equalTo(@42);
            
        }];
        //3.接单按钮
        [self addSubview:self.takeBtn];
        [self.takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_bottom).offset(20);
            make.right.equalTo(self.contentView);
            make.left.equalTo(self.rejectBtn.mas_right).offset(30);
            make.height.equalTo(@42);
        }];
        
        UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Actiondo:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];

}

#pragma mark - private method
//创建工单子项目
-(void)createContentSubView{
    
    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@74);
    }];
    
    UIView *view2 = [[UIView alloc]init];
    view2.backgroundColor = [Common colorFromHexRGB:@"3e8aed"];
    [self.contentView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@100);
    }];
    
    UIView *view3 = [[UIView alloc]init];
    view3.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@80);
    }];
    
    UIView *view4 = [[UIView alloc]init];
    view4.backgroundColor = [Common colorFromHexRGB:@"eeeeee"];
    [self.contentView addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    UIButton *showMapBtn = [[UIButton alloc]init];
    [showMapBtn setTitle:@"点击查看地图" forState:UIControlStateNormal];
    showMapBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [showMapBtn setTitleColor:[Common colorFromHexRGB:@"5b6c80"] forState:UIControlStateNormal];
    [showMapBtn addTarget:self action:@selector(showMap:) forControlEvents:UIControlEventTouchUpInside];
    [view4 addSubview:showMapBtn];
    [showMapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view4);
    }];


    
}

/**
 *  拒绝
 */
-(void)reject:(UIButton *)button{
    NSLog(@"reject");
    [self removeFromSuperview];
#pragma mark -拒绝
    TestVC *testVC = [[TestVC alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = (UINavigationController *)window.rootViewController;
    [nav pushViewController:testVC animated:YES];
    
}

/**
 *  接受
 */
-(void)take:(UIButton *)button{
    NSLog(@"take");
    [self removeFromSuperview];
    
    MapViewController *mapVC = [[MapViewController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UINavigationController *nav = (UINavigationController *)window.rootViewController;
    [nav pushViewController:mapVC animated:YES];
    



}

-(void)timeFireMethod{
    NSLog(@"timeFireMethod");
    //倒计时-1
    _secondsCountDown--;
    //修改倒计时按钮显示内容
    NSString *desc = [NSString stringWithFormat:@"接单(%ds)",_secondsCountDown];
    [self.takeBtn setTitle:desc forState:UIControlStateNormal];
    //当倒计时到0时,移除单子
    if(_secondsCountDown==0){
        [_takeTaskTimer invalidate];
        [self removeFromSuperview];
    }
}

#pragma mark - get / set
//单子内容
-(UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor grayColor];
        setViewCorner(_contentView, 5.0);
    }
    return _contentView;
}

//拒绝按钮
-(UIButton *)rejectBtn {
    if (_rejectBtn == nil) {
        _rejectBtn = [[UIButton alloc]init];
        _rejectBtn.backgroundColor = [UIColor whiteColor];
        [_rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
        [_rejectBtn addTarget:self action:@selector(reject:) forControlEvents:UIControlEventTouchUpInside];
        [_rejectBtn setTitleColor:[Common colorFromHexRGB:@"323c46"] forState:UIControlStateNormal];
        setViewCorner(_rejectBtn, 20.0);
    }
    return _rejectBtn;
}

//接受按钮
-(UIButton *)takeBtn{
    if (_takeBtn == nil) {
        _takeBtn = [[UIButton alloc]init];
        _takeBtn.backgroundColor = [Common colorFromHexRGB:@"ed5d39"];
        NSString *desc = [NSString stringWithFormat:@"接单(%ds)",_secondsCountDown];
        [_takeBtn setTitle:desc forState:UIControlStateNormal];
        [_takeBtn addTarget:self action:@selector(take:) forControlEvents:UIControlEventTouchUpInside];
        setViewCorner(_takeBtn, 20.0);
    }
    return _takeBtn;
}

-(void)Actiondo:(UIGestureRecognizer *)gesture{
    [self removeFromSuperview];
}

//展示地图
-(void)showMap:(UIButton *)button{
    
}




@end


















