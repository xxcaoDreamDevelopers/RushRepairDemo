//
//  AllPerformanceTableViewCell.h
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PerFormanceTypeRuskTask,
    PerFormanceTypeCollect,
    PerFormanceTypeAbility,
} PerFormanceType;


@interface AllPerformanceTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *allPerformance;

@property (nonatomic, copy) void(^perFormanceBlock)(PerFormanceType type);

@end
