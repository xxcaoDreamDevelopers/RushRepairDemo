//
//  PerformanceRushTableViewCell.h
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerformanceRushTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *complaintNumber;

@property (weak, nonatomic) IBOutlet UILabel *complaintDetail;


@property (weak, nonatomic) IBOutlet UILabel *testNumber;

@property (weak, nonatomic) IBOutlet UILabel *testDetail;


@property (weak, nonatomic) IBOutlet UILabel *practiseNumber;

@property (weak, nonatomic) IBOutlet UILabel *practiseDetail;

@end
