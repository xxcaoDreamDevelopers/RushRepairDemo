//
//  TaskDetailFooter.m
//  IOVS
//
//  Created by Dale on 16/9/27.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskDetailFooter.h"
#import "UIColor+HEX.h"
@interface TaskDetailFooter()
@property (nonatomic, strong) UIButton *btn;
@end
@implementation TaskDetailFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //1.去这里
        UIButton *goHereBtn = [[UIButton alloc]init];
        goHereBtn.backgroundColor = [UIColor colorWithHexString:@"11c63c"];
        [goHereBtn setTitle:@"去这里" forState:UIControlStateNormal];
        [goHereBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        goHereBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [goHereBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:goHereBtn];
//        [goHereBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(20);
//            make.right.equalTo(self).offset(-20);
//            make.top.equalTo(self).offset(12);
//            make.bottom.equalTo(self).offset(-12);
//        }];
        goHereBtn.tag = 0;
        goHereBtn.layer.borderWidth = 1;
        goHereBtn.layer.borderColor = ColorRGB(30, 169, 69).CGColor;
        setViewCorner(goHereBtn, 5);
    
        
        
        //2.开始检修
        UIButton *repairBtn = [[UIButton alloc]init];
        repairBtn.backgroundColor = [UIColor colorWithHexString:@"f57f0a"];
        [repairBtn setTitle:@"填写工单" forState:UIControlStateNormal];
        [repairBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        repairBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [repairBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:repairBtn];
//        [repairBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self).offset(20);
//            make.right.equalTo(self).offset(-20);
//            make.top.equalTo(self).offset(12);
//            make.bottom.equalTo(self).offset(-12);
//        }];
        repairBtn.tag = 1;
        repairBtn.layer.borderWidth = 1;
        repairBtn.layer.borderColor = ColorRGB(213, 106, 0).CGColor;
        setViewCorner(repairBtn, 5);
        
    }
    return self;
}

#pragma mark - lifeCycle
-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat btnX = 20.0;
    CGFloat btnY = 10.0;
    CGFloat btnW = (self.frame.size.width - 50) / 2;
    CGFloat btnH = 38;
    for (int index = 0; index < self.subviews.count; index++) {
        UIButton *btn = self.subviews[index];
        btnX = (btnW + 10) * index + btnX;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
}


#pragma mark - private method
-(void)click:(UIButton *)btn {
    if (self.ButtonClickBlock) {
        self.ButtonClickBlock(btn.tag);
    }
}

@end


















