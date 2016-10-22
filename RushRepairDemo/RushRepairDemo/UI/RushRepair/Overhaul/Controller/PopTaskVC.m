//
//  PopTaskVC.m
//  IOVS
//
//  Created by UPBest_iOS_1 on 16/9/20.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "PopTaskVC.h"
#import "RushRepairDemo-Swift.h"
@interface PopTaskVC ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation PopTaskVC

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(125);
        make.left.equalTo(self.view).offset(36);
        make.right.equalTo(self.view).offset(-36);
        make.height.equalTo(@300);
    }];
    setViewCorner(self.contentView, 5.0);
    [self createSubViews];
    
    
    UIButton *rejectBtn = [[UIButton alloc]init];
    rejectBtn.backgroundColor = [UIColor whiteColor];
    [rejectBtn setTitle:@"拒绝" forState:UIControlStateNormal];
    rejectBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [rejectBtn setTitleColor:[Common colorFromHexRGB:@"323c46"] forState:UIControlStateNormal];
    [rejectBtn addTarget:self action:@selector(reject:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rejectBtn];
    [rejectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(20);
        make.left.equalTo(self.contentView);
        make.width.equalTo(@80);
        make.height.equalTo(@42);
    }];
    setViewCorner(rejectBtn, 20.0);
    
    UIButton *takeBtn = [[UIButton alloc]init];
    takeBtn.backgroundColor = [Common colorFromHexRGB:@"ed5d39"];
    takeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [takeBtn setTitle:@"接受" forState:UIControlStateNormal];
    [takeBtn addTarget:self action:@selector(take:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:takeBtn];
    [takeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom).offset(20);
        make.right.equalTo(self.contentView);
        make.width.equalTo(@160);
        make.height.equalTo(@42);
    }];
    setViewCorner(takeBtn, 20.0);
    
}



#pragma mark - private method

/**
 *  创建子view
 */
-(void)createSubViews{
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
    

    
}

/**
 *  拒绝
 */
-(void)reject:(UIButton *)button{
    NSLog(@"reject");
}

/**
 *  接受
 */
-(void)take:(UIButton *)button{
    NSLog(@"take");
    MapViewController *mapVC = [[MapViewController alloc] init];
    [self.navigationController pushViewController:mapVC animated:YES];
}

#pragma mark - getter / setter
-(UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor redColor];
    }
    return _contentView;
}



@end




























