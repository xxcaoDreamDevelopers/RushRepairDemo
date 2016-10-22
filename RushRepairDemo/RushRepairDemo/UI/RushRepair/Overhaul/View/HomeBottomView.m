//
//  HomeBottomView.m
//  IOVS
//
//  Created by Dale on 16/9/24.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "HomeBottomView.h"
#import "SEFilterControl.h"
#import "TaskFilterView.h"
#import "UIColor+HEX.h"
@interface HomeBottomView()

@property (nonatomic, strong) TaskFilterView *filterView;
//@property (nonatomic, strong) UIButton *unConfirmbtn;
@end
@implementation HomeBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        [self createSubViews];
        //1.创建滑块
        
        //2.创建筛选按钮
        
        //3.未确认按钮
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [self addGestureRecognizer:pan];
        
    }
    return self;
}

-(void)createSubViews{
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"c9c9c9"];
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 6, 20, 3)];
    line2.backgroundColor = [UIColor colorWithHexString:@"c9c9c9"];
    line2.center = CGPointMake(self.frame.size.width / 2, 6);
    [self addSubview:line2];
    
  
    
    // Do any additional setup after loading the view, typically from a nib.
    _filter = [[SEFilterControl alloc]initWithFrame:CGRectMake(25, 9, self.frame.size.width - 50, 15) Titles:[NSArray arrayWithObjects:@"客服",@"检修", @"特巡", @"巡视", @"失败", nil] taskNumbers:@[@8,@6,@6,@5,@2]];
    ;
    
    
    [_filter setProgressColor:[UIColor groupTableViewBackgroundColor]];//设置滑杆的颜色
    [_filter setTopTitlesColor:[UIColor orangeColor]];//设置滑块上方字体颜色
    [_filter setSelectedIndex:0];//设置当前选中
    _filter.backgroundColor = [UIColor whiteColor];
    [self addSubview:_filter];
    [_filter addTarget:self action:@selector(selectItem:) forControlEvents:UIControlEventTouchUpInside];
    


//    _unConfirmbtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 75, 80, 42)];
//    [_unConfirmbtn setTitle:@"未确认" forState:UIControlStateNormal];
//    [_unConfirmbtn setTitleColor:[UIColor colorWithHexString:@"eebe93"] forState:UIControlStateNormal];
//    [_unConfirmbtn setBackgroundImage:[UIImage imageNamed:@"selectBg"] forState:UIControlStateSelected];
//    [_unConfirmbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
//    _unConfirmbtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
//    [_unConfirmbtn addTarget:self action:@selector(selectUnconfirmTasks:) forControlEvents:UIControlEventTouchDown];
//    _unConfirmbtn.tag = EFilterTypeSourceUnConfirm;
//    [self addSubview:_unConfirmbtn];
////    unConfirmbtn.backgroundColor = [UIColor redColor];
//    setViewBorder(_unConfirmbtn, 0.3);
//    setViewCorner(_unConfirmbtn, 3);
    
    
    _filterView = [[TaskFilterView alloc]initWithFrame:CGRectMake(15, 75, self.frame.size.width - 30, 42)];

    WeakSelf;
    [self reloadFilterViewWithSelectedIndex:0];
    
   
    _filterView.myBlock = ^(NSUInteger btnTag, NSUInteger parentIndex, BOOL isSelected){
//        wSelf.unConfirmbtn.selected = NO;
        if (wself.FilterBlock) {
            wself.FilterBlock(btnTag,parentIndex,isSelected);
        }
    };
    
    
    
    [self addSubview:_filterView];
//    setViewBorder(_filterView, 0.3);
//    setViewCorner(_filterView, 3);
    

}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self createSubViews];
}

//筛选未确认工单
-(void)selectUnconfirmTasks:(UIButton *)button{
//    if (self.FilterBlock) {
//        self.FilterBlock(button.tag);
//    }
    button.selected = !button.selected;
    [_filterView refreshBtns];
}

-(void)pan:(UIPanGestureRecognizer *)rec{
    CGFloat translation = [rec translationInView:self].y;
    
    self.transform = CGAffineTransformMakeTranslation(0, translation);
    
}

-(void)selectItem:(SEFilterControl *)se{
    [_filterView refreshBtns];
//    _unConfirmbtn.selected = NO;
    NSLog(@"%d",se.SelectedIndex);
    if (self.SelectItem) {
        self.SelectItem(se.SelectedIndex);
    }
    [self reloadFilterViewWithSelectedIndex:se.SelectedIndex];
}


-(void)reloadFilterViewWithSelectedIndex:(NSUInteger)index{
    switch (index) {
        case EItemTypePlanRepair:
            _filterView.filterTitles = @[@"平台监测 (3)",@"巡视报修 (2)"];
            _filterView.parentIndex = index;
            [_filterView layoutSubviews];

            break;
        case EItemTypeTour:
            _filterView.filterTitles = @[];
            _filterView.parentIndex = index;
            [_filterView layoutSubviews];
            break;
        case EItemTypeFailureTask:
            _filterView.filterTitles = @[@"客服 (2)",@"特巡 (3)"];
            _filterView.parentIndex = index;
            [_filterView layoutSubviews];
            break;
        case EItemTypeSpecialTour:
            _filterView.filterTitles = @[@"平台监测 (2)",@"其他来源 (3)",@"未确认 (2)"];
            _filterView.parentIndex = index;
            [_filterView layoutSubviews];
            break;
        case EItemTypeCustomService:
            _filterView.filterTitles = @[@"95598 (2)",@"其他来源 (3)",@"未确认 (2)"];
            _filterView.parentIndex = index;
            [_filterView layoutSubviews];
            break;
        default:
            break;
    }
}
@end


