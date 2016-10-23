//
//  PerformanceVCViewController.m
//  MPP
//
//  Created by 齐云 on 16/7/15.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "RRScoreViewController.h"
#import "AllPerformanceTableViewCell.h"
#import "PerformanceDetailTableViewCell.h"
#import "PerformanceRushTableViewCell.h"
#import "DVLineChartView.h"
#import "UIView+Extension.h"
#import "MonthPerformanceTableViewCell.h"
#import "UIColor+HEX.h"
typedef enum : NSUInteger {
    PerFormanceTypeVCRushTask,
    PerFormanceTypeVCCollect,
    PerFormanceTypeVCAbility,
} PerFormanceTypeVC;

@interface RRScoreViewController ()<UITableViewDataSource,UITableViewDelegate,DVLineChartViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,assign) PerFormanceTypeVC type;
@property (nonatomic, strong) NSArray *titelArr;
@property (nonatomic, strong) NSArray *detailArr;

@end

@implementation RRScoreViewController
#pragma mark -----------------lifeCycle--------------
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.titelArr = @[@[@"配抢工单总数",@"配抢工单完成数",@"单位内平均每月完成工单数",@"30分钟内到达现场",@"工单投诉"],@[@"归档工单",@"接受工单总数",@"执行工单总数",@"单位内平均每月完成工单"],@[@"答题总数",@"正确总数"]];
    self.detailArr = @[@[@"129",@"32",@"44",@"12",@"44"],@[@"121",@"312",@"21",@"434"],@[@"121",@"444"]];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------delegate------
#pragma mark UITableViewDataSource,UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section  == 0 || section == 1 || section == 2) {
        return 1;
    }else {
        return [self.titelArr[section - 3] count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf;
    if (indexPath.section == 0) {
        AllPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AllPerformanceTableViewCellID"];
        if (!cell) {
            cell = LoadFromNib(@"AllPerformanceTableViewCell");
        }
        
        [cell setPerFormanceBlock:^(PerFormanceType type) {
            switch (type) {
                case PerFormanceTypeRuskTask:
                    wself.type = PerFormanceTypeVCRushTask;
                    break;
                case PerFormanceTypeCollect:
                    wself.type = PerFormanceTypeVCCollect;
                    break;
                case PerFormanceTypeAbility:
                    wself.type = PerFormanceTypeVCAbility;
                    break;
                default:
                    break;
            }
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        return [[UITableViewCell alloc] init];
        return cell;
    }else if (indexPath.section == 1){
        switch (self.type) {
            case PerFormanceTypeVCRushTask: {
                PerformanceRushTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerformanceRushTableViewCellID"];
                if (!cell) {
                    cell = LoadFromNib(@"PerformanceRushTableViewCell");
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case PerFormanceTypeVCCollect: {
                PerformanceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerformanceDetailTableViewCelID"];
                if (!cell) {
                    cell = LoadFromNib(@"PerformanceDetailTableViewCell");
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            case PerFormanceTypeVCAbility: {
                PerformanceDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PerformanceDetailTableViewCelID"];
                if (!cell) {
                    cell = LoadFromNib(@"PerformanceDetailTableViewCell");
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
                break;
            default:
                break;
        }
    }else if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.backgroundColor = [UIColor colorWithHexString:@"#f3f3f4"];
        DVLineChartView *ccc = [[DVLineChartView alloc] init];
        ccc.yAxisViewWidth = 40;
        ccc.numberOfYAxisElements = 5;
        ccc.delegate = self;
        ccc.pointUserInteractionEnabled = YES;
        ccc.yAxisMaxValue = 100;
        ccc.pointGap = 35;
        ccc.showSeparate = YES;
        ccc.separateColor = [UIColor colorWithHexString:@"#d9d9d9"];
        ccc.textColor = [UIColor colorWithHexString:@"#999999"];
        ccc.backColor = [UIColor colorWithHexString:@"#f3f3f4"];
        ccc.axisColor = [UIColor colorWithHexString:@"#67707c"];
        ccc.xAxisTitleArray = @[@"1月", @"2月", @"3月", @"4月", @"5月", @"6月", @"7月", @"8月", @"9月", @"10月", @"11月", @"12月"];
        ccc.x = 0;
        ccc.y = 0;
        ccc.width = self.view.width;
        ccc.height = 160;
        DVPlot *plot = [[DVPlot alloc] init];
        plot.pointArray = @[@30, @55, @70, @20, @37, @89, @76, @43, @21, @30, @30, @55];
        plot.lineColor = [UIColor colorWithHexString:@"#d4e8f6"];
        plot.pointColor = [UIColor colorWithHexString:@"14b9d6"];
        plot.chartViewFill = YES;
        plot.withPoint = YES;
        [ccc addPlot:plot];
        [ccc draw];
        [cell.contentView addSubview:ccc];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        MonthPerformanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MonthPerformanceTableViewCellID"];
        if (!cell) {
            cell = LoadFromNib(@"MonthPerformanceTableViewCell");
        }
        NSArray *arr = self.titelArr[indexPath.section - 3];
        cell.title.text = arr[indexPath.row];
        NSArray *detail = self.detailArr[indexPath.section - 3];
        cell.detail.text = detail[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.tableView.estimatedRowHeight = 30;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        return self.tableView.rowHeight;
    }else if(indexPath.section == 1){
        self.tableView.estimatedRowHeight = 30;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        return self.tableView.rowHeight;
    }else if (indexPath.section == 2) {
        return 170;
    }
    return 36;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section > 2) {
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHexString:@"#c1c1c1"];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, Screen_Width - 30, 20)];
        if (section == 3) {
            label.text = @"本月配抢详情";
        }else if (section == 4) {
            label.text = @"本月采集运维详情";
        }else {
            label.text = @"本月能力提升详情";
        }
        label.textColor = [UIColor whiteColor];
        [view addSubview:label];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 2) {
        return 35;
    }
    return 0.00001;
}


#pragma mark ----------------CustumMethod-------------
-(void)initUI {
    self.title = @"积分";
    self.navigationItem.leftBarButtonItem = [Common createBackBarButton:nil Selector:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, default_NavigationHeight, Screen_Width, Screen_Height - default_NavigationHeight) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

@end
