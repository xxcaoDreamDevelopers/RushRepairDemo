//
//  AdTableViewCell.m
//  MPP
//
//  Created by 齐云 on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "AdTableViewCell.h"

@implementation AdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    setViewCorner(self.timeLabel, 5);
    setViewCorner(self.bgView, 5);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)toMessageDetailAction:(UIButton *)sender {
    if (self.toMessageDetailBlock) {
        self.toMessageDetailBlock(sender);
    }
}

@end
