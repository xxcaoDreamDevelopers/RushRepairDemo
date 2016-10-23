//
//  AdTableViewCell.h
//  MPP
//
//  Created by 齐云 on 16/7/19.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdTableViewCell : UITableViewCell


@property (nonatomic, copy) void(^toMessageDetailBlock)(UIButton *btn);

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (weak, nonatomic) IBOutlet UIView *bgView;




@end
