//
//  RRHeadLineViewController.m
//  RushRepairDemo
//
//  Created by xxcao on 2016/10/21.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "RRHeadLineViewController.h"

@interface RRHeadLineViewController ()

@end

@implementation RRHeadLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"头条";
    self.navigationItem.leftBarButtonItem = [Common createBackBarButton:nil Selector:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
