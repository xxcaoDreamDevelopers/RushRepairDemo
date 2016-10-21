//
//  RootViewController.m
//  MPP
//
//  Created by 齐云 on 16/7/8.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "RootViewController.h"
#import "LeftMenuViewController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#import "UINavigationController+WXSTransition.h"
#import "MBProgressController.h"
#import "RRHeadLineViewController.h"
#import "RRRushRepairViewController.h"
#import "RRSpecailViewViewController.h"
#import "RRNormalViewViewController.h"
#import "RRScoreViewController.h"


@interface RootViewController ()


@property (weak, nonatomic) IBOutlet UIView *rootAdView;
@property (weak, nonatomic) IBOutlet UIView *rootRushView;
@property (weak, nonatomic) IBOutlet UILabel *repairNum;
@property (weak, nonatomic) IBOutlet UILabel *nearRepairNum;

@property (weak, nonatomic) IBOutlet UIView *rootCollectView;
@property (weak, nonatomic) IBOutlet UILabel *collectionNum;
@property (weak, nonatomic) IBOutlet UILabel *nearCollectNum;

@property (weak, nonatomic) IBOutlet UIView *rootOtherView;

@property (weak, nonatomic) IBOutlet UIView *rootKnowlegeView;
@property (weak, nonatomic) IBOutlet UILabel *knowlegeNum;

@property (weak, nonatomic) IBOutlet UIView *rootTestView;
@property (weak, nonatomic) IBOutlet UILabel *testNum;

@property (weak, nonatomic) IBOutlet UIView *rootPerformenceView;
@property (weak, nonatomic) IBOutlet UILabel *performNum;


@property(nonatomic,weak)IBOutlet UIButton *btn1;
@property(nonatomic,weak)IBOutlet UIButton *btn2;
@property(nonatomic,weak)IBOutlet UIButton *btn5;
@property(nonatomic,weak)IBOutlet UIButton *btn6;
@property(nonatomic,weak)IBOutlet UIButton *btn7;

@property (nonatomic, strong) UIView *snapView;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self restorePrevious];
    [self.snapView removeFromSuperview];
}


-(NSAttributedString *)attributeStr:(NSString *)str {
    NSString *knowlege = [NSString stringWithFormat:@"已积累%@个",str];
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:knowlege];
    
    [attribute addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(3, str.length)];
    
    return attribute;
}


#pragma -mark UIButton Action
//头条
- (IBAction)adAction:(id)sender {
    if (self.btn1.userInteractionEnabled) {
        [self setBtnEnabled:1];
        [self jumpToVCWithAnimation:EAdHeadLine];
    }
}

//配抢作业
- (IBAction)rushRepairAction:(UIButton *)sender {
    if (self.btn2.userInteractionEnabled) {
        [self setBtnEnabled:2];
        [self jumpToVCWithAnimation:ERushRepair];
    }
}

- (IBAction)rushRepairAction2:(UIButton *)sender {
    [self animationView:self.rootRushView];
}

- (IBAction)rushRepairAction3:(UIButton *)sender {
    [self animationViewOriginalView];
}


//特殊巡视
- (IBAction)knowledgeAction:(UIButton *)sender {
    if (self.btn5.userInteractionEnabled) {
        [self setBtnEnabled:5];
        [self jumpToVCWithAnimation:ESpecialView];
    }
 }

- (IBAction)knowledgeAction2:(UIButton *)sender {
    [self animationView:self.rootKnowlegeView];
}

- (IBAction)knowledgeAction3:(UIButton *)sender {
    [self animationViewOriginalView];
}


//正常巡视
- (IBAction)monthIntegrationAction:(id)sender {
    if (self.btn6.userInteractionEnabled) {
        [self setBtnEnabled:6];
        [self jumpToVCWithAnimation:ENormalView];
    }
}

- (IBAction)monthIntegrationAction2:(id)sender {
    [self animationView:self.rootTestView];
}

- (IBAction)monthIntegrationAction3:(id)sender {
    [self animationViewOriginalView];
}

//总的积分
- (IBAction)integrationAction:(UIButton *)sender {
    if (self.btn7.userInteractionEnabled) {
        [self setBtnEnabled:7];
        [self jumpToVCWithAnimation:EScore];
    }
}

- (IBAction)integrationAction2:(UIButton *)sender {
    [self animationView:self.rootPerformenceView];
}

- (IBAction)integrationAction3:(UIButton *)sender {
    [self animationViewOriginalView];
}


#pragma -mark

- (void)jumpToVCWithAnimation:(EModelType)modelName {
    switch (modelName) {
        case EAdHeadLine: {
            RRHeadLineViewController *headLineVC = [[RRHeadLineViewController alloc] init];
            [self.navigationController wxs_pushViewController:headLineVC makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeBoom;
                transition.animationTime = 0.6;
            }];
            break;
        }
        case ERushRepair: {
            RRRushRepairViewController *rushRepairVC = [[RRRushRepairViewController alloc] init];
            [self.navigationController wxs_pushViewController:rushRepairVC makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeBoom;
                transition.animationTime = 0.6;
            }];
            break;
        }
        case ESpecialView: {
            RRSpecailViewViewController *specialVC = [[RRSpecailViewViewController alloc] init];
            [self.navigationController wxs_pushViewController:specialVC makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeBoom;
                transition.animationTime = 0.6;
            }];
            break;
        }
        case ENormalView: {
            RRNormalViewViewController *normalVC = [[RRNormalViewViewController alloc] init];
            [self.navigationController wxs_pushViewController:normalVC makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeBoom;
                transition.animationTime = 0.6;
            }];
            break;
        }
        case EScore: {
            RRScoreViewController *scoreVC = [[RRScoreViewController alloc] init];
            [self.navigationController wxs_pushViewController:scoreVC makeTransition:^(WXSTransitionProperty *transition) {
                transition.animationType = WXSTransitionAnimationTypeBoom;
                transition.animationTime = 0.6;
            }];
            break;
        }
        default:
            break;
    }
}


- (void)setBtnEnabled:(int)index {
    self.btn1.userInteractionEnabled = NO;
    self.btn2.userInteractionEnabled = NO;
    self.btn5.userInteractionEnabled = NO;
    self.btn6.userInteractionEnabled = NO;
    self.btn7.userInteractionEnabled = NO;

    switch (index) {
        case 1:{
            self.btn1.userInteractionEnabled = YES;
            break;
        }
        case 2:{
            self.btn2.userInteractionEnabled = YES;
            break;
        }
        case 5:{
            self.btn5.userInteractionEnabled = YES;
            break;
        }
        case 6:{
            self.btn6.userInteractionEnabled = YES;
            break;
        }
        case 7:{
            self.btn7.userInteractionEnabled = YES;
            break;
        }
        default:
            break;
    }
}

- (void)restorePrevious {
    self.btn1.userInteractionEnabled = YES;
    self.btn2.userInteractionEnabled = YES;
    self.btn5.userInteractionEnabled = YES;
    self.btn6.userInteractionEnabled = YES;
    self.btn7.userInteractionEnabled = YES;
}

//截图
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    return snapshot;
}

//开启视图动画
-(void)animationView:(UIView *)view {
    self.snapView = [self customSnapshoFromView:view];
    [self.view addSubview:self.snapView];
    self.snapView.center = view.center;
    self.snapView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    self.snapView.transform=CGAffineTransformMakeScale(1.1f, 1.1f);//先让要显示的view最小直至消失
    [UIView commitAnimations]; //启动动画
}
//关闭视图动画
-(void)animationViewOriginalView {
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:0.5f];//动画时间
    self.snapView.transform=CGAffineTransformMakeScale(1.0f, 1.0f);//先让要显示的view最小直至消失
    [UIView commitAnimations]; //启动动画
    [self.snapView removeFromSuperview];
}


@end
