//
//  RRScoreViewController.m
//  RushRepairDemo
//
//  Created by xxcao on 2016/10/21.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "RRScoreViewController.h"

@interface RRScoreViewController ()

@end

@implementation RRScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
