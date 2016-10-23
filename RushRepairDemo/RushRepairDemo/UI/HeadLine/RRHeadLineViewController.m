//
//  AdViewController.m
//  MPP
//
//  Created by 齐云 on 16/7/8.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "RRHeadLineViewController.h"
#import "AdTableViewCell.h"

@interface RRHeadLineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RRHeadLineViewController
#pragma mark ------------lifeCycle---------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -----------delegate---------
#pragma mark -UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdTableViewCellID"];
    if (!cell) {
        cell = LoadFromNib(@"AdTableViewCell");
    }
    [cell setToMessageDetailBlock:^(UIButton * btn) {

    }];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    return self.tableView.rowHeight;
}

#pragma mark --------------customeMethod---------
- (void)configUI {
    self.title = @"头条";
    self.tableView.backgroundColor = [Common colorFromHexRGB:@"f4f4f6"];
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [Common colorFromHexRGB:@"f4f4f6"];
    self.tableView.backgroundView = v;
    self.navigationItem.leftBarButtonItem = [Common createBackBarButton:nil Selector:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

#pragma mark  ------------------getter,setter----------
-(UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, default_NavigationHeight, Screen_Width, Screen_Height - default_NavigationHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
