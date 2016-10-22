//
//  TopCellView.m
//  IOVS
//
//  Created by mac on 16/10/14.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TopCellView.h"
@interface TopCellView()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end
@implementation TopCellView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //1.icon
        UIImageView *icon = [[UIImageView alloc]init];
        [self addSubview:icon];
        icon.image = [UIImage imageNamed:@"icon_state"];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).offset(-20);
            make.centerY.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.3);
            make.height.equalTo(icon.mas_width);
        }];
        self.icon = icon;
        
        //2.desc
        UILabel *descLabel = [[UILabel alloc]init];
        descLabel.text = @"工单状态";
        descLabel.textColor = [Common colorFromHexRGB:@"989898"];
        descLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:descLabel];
        [descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-10);
            make.bottom.equalTo(icon.mas_centerY).offset(-2);
//            make.width.equalTo(self).multipliedBy(0.29);
//            make.height.equalTo(self).multipliedBy(0.17);
        }];
//        descLabel.adjustsFontSizeToFitWidth = YES;
        self.descLabel = descLabel;
        
        //3.detail
        UILabel *detailLabel = [[UILabel alloc]init];
        detailLabel.textColor = [Common colorFromHexRGB:@"343434"];
        detailLabel.text = @"未执行";
//        detailLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:detailLabel];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-10);
            make.top.equalTo(icon.mas_centerY).offset(2);
        }];
//        detailLabel.adjustsFontSizeToFitWidth = YES;
        self.detailLabel = detailLabel;
        [self fitFont];
    }
    return self;
}

-(void)setDetailModel:(TaskDetailModel *)detailModel{
    _detailModel = detailModel;
    self.descLabel.text = detailModel.desc;
    self.detailLabel.text = detailModel.detail;
    self.icon.image = [UIImage imageNamed:detailModel.icon];
    self.detailLabel.textColor = [Common colorFromHexRGB:detailModel.taskTypeColor];
}

-(void)fitFont{
    if (is40inch) {
        self.detailLabel.font = [UIFont systemFontOfSize:12];
    }else if (is47inch){
        self.detailLabel.font = [UIFont systemFontOfSize:13];
    }else if (is55inch){
        self.detailLabel.font = [UIFont systemFontOfSize:15];
    }else
        self.detailLabel.font = [UIFont systemFontOfSize:8];
    
}

@end













