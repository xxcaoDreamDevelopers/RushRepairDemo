//
//  TaskDetailCell.m
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskDetailCell.h"
#import "TaskDetailModel.h"
@interface TaskDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UIImageView *callLabel;

@end
@implementation TaskDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDetailModel:(TaskDetailModel *)detailModel{
    _detailModel = detailModel;
    self.descLabel.text = detailModel.desc;
    self.detailLabel.text = detailModel.detail;
    self.iconView.image = [UIImage imageNamed:detailModel.icon];
    self.callLabel.hidden = detailModel.isHidden;
}

@end
