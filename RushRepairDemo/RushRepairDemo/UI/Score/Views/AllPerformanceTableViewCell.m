//
//  AllPerformanceTableViewCell.m
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "AllPerformanceTableViewCell.h"

@implementation AllPerformanceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

//    NSLog(@"%@",NSStringFromCGRect(self.contentView.frame));




}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews {
    [super layoutSubviews];
    
}


//抢修业务
- (IBAction)rushTaskAction:(UIButton *)sender {
    if (self.perFormanceBlock) {
        self.perFormanceBlock(PerFormanceTypeRuskTask);
    }
}

//采集运维
- (IBAction)collectAction:(UIButton *)sender {
    if (self.perFormanceBlock) {
        self.perFormanceBlock(PerFormanceTypeCollect);
    }
}

//能力提升
- (IBAction)abilityAction:(UIButton *)sender {
    if (self.perFormanceBlock) {
        self.perFormanceBlock(PerFormanceTypeAbility);
    }
}


















@end
