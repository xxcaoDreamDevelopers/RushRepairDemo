//
//  PerformanceDetailTableViewCell.m
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "PerformanceDetailTableViewCell.h"

@implementation PerformanceDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIFont *numberIphone6 = [UIFont systemFontOfSize:27];
    UIFont *detailIphone6 = [UIFont systemFontOfSize:14];
    
    UIFont *numberIphone5 = [UIFont systemFontOfSize:22];
    UIFont *detailIphone5 = [UIFont systemFontOfSize:10];
    
    if (isIPhone5) {
        self.testNumber.font = numberIphone5;
        self.practiseNumber.font = numberIphone5;
        
        self.testDetail.font = detailIphone5;
        self.practiseDetail.font = detailIphone5;
        
    }else if (isIPhone6){
        self.testNumber.font = numberIphone6;
        self.practiseNumber.font = numberIphone6;
        
        self.testDetail.font = detailIphone6;
        self.practiseDetail.font = detailIphone6;

    
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
