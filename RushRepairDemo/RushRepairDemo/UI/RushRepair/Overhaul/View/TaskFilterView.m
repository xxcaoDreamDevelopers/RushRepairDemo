//
//  TaskFilterView.m
//  IOVS
//
//  Created by Dale on 16/9/23.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskFilterView.h"
#import "UIColor+HEX.h"
#define UnConfirmBtnWidth 70
@interface TaskFilterView()
@property (nonatomic, strong) UIButton *currentSelectBtn;//当前选中按钮
@property (nonatomic, strong) NSMutableArray *lines;
@property (nonatomic, strong) NSMutableArray *btns;//筛选按钮数组
@end
@implementation TaskFilterView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

#pragma mark - life cycle
-(void)layoutSubviews{
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    [self.btns removeAllObjects];
    [self.lines removeAllObjects];
    if (!(self.filterTitles.count > 0)) {
        return;
    }
    

    
    if (self.parentIndex == EItemTypeCustomService || self.parentIndex == EItemTypeSpecialTour) {
        [self createUnConfirmBtn];
    }
    
    if (self.parentIndex == EItemTypeCustomService || self.parentIndex == EItemTypeSpecialTour) {
        _unConfirmBtn.frame = CGRectMake(self.frame.size.width - UnConfirmBtnWidth, 0, UnConfirmBtnWidth, self.frame.size.height);
    }
    
    CGFloat filterW;
    if (self.parentIndex == EItemTypeCustomService || self.parentIndex == EItemTypeSpecialTour) {
        filterW = self.frame.size.width - UnConfirmBtnWidth - 10;
    }else {
        filterW = self.frame.size.width;
    }
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, filterW, self.frame.size.height)];
    [self addSubview:bgView];
    
    setViewBorder(bgView, 0.3);
    setViewCorner(bgView, 3);
    
    //1.创建筛选按钮
    [self createFilterBtns];
    
    //2.创建分隔线
    [self createLines];
    
    //按钮
    CGFloat btnW = filterW / self.btns.count;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnX;
    CGFloat btnY = 0;
    for (int index = 0; index < self.btns.count; index++) {
        btnX = index * btnW;
        UIButton *button = self.btns[index];
        button.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    //分割线
    CGFloat lineW = 0.3;
    CGFloat lineH = self.frame.size.height;
    CGFloat lineX;
    CGFloat lineY = 0;
    for (int index = 0; index < self.lines.count; index++) {
        lineX = btnW * (index + 1);
        UIButton *button = self.lines[index];
        button.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }
}

#pragma mark - private method

//创建筛选按钮
-(void)createFilterBtns{
    NSUInteger btnCount;
    if (self.parentIndex == EItemTypeFailureTask || self.parentIndex == EItemTypeTour || self.parentIndex == EItemTypePlanRepair) {
        btnCount = self.filterTitles.count;
    }
    else {
        btnCount = self.filterTitles.count - 1;
    }
    
    for (int index = 0; index < btnCount; index++) {
        UIButton *btn = [[UIButton alloc]init];
        [self settingButton:btn WithTitle:self.filterTitles[index] titleColor:[UIColor colorWithHexString:@"333333"]  selectedTitleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:11.0] selectedBgImage:[UIImage imageNamed:@"selectBg"] sel:@selector(filterSource:)];
//        srcTelBtn.tag = EFilterTypeSourceTelphone;
        [self tagBtn:btn :index];
        [self addSubview:btn];
        [self.btns addObject:btn];
    }
}

//创建一个筛选按钮
-(void)settingButton:(UIButton *)button WithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor font:(UIFont *)font selectedBgImage:(UIImage *)selectedBgImage sel:(SEL)sel{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:selectedTitleColor forState:UIControlStateSelected];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundImage:selectedBgImage forState:UIControlStateSelected];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchDown];
}

//创建线
-(void)createLines{
    NSUInteger lineCount;
    if (self.parentIndex == EItemTypeFailureTask || self.parentIndex == EItemTypeTour || self.parentIndex == EItemTypePlanRepair) {
        lineCount = self.filterTitles.count - 1;
    }
    else {
        lineCount = self.filterTitles.count - 2;
    }
    for (int index = 0; index < lineCount; index++) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        [self addSubview:line];
        [self.lines addObject:line];
    }
}


-(void)refreshBtns {
    self.currentSelectBtn.selected = NO;
}

-(void)tagBtn:(UIButton *)btn :(int)index{
    switch (self.parentIndex) {
            
        case EItemTypeCustomService:{
            switch (index) {
                case 0:
                    btn.tag = EFilterTypeSource95598;//95598
                    break;
                case 1:
                    btn.tag = EFilterTypeSourceOther;//其他来源
                    break;
                default:
                    break;
            }
        }
        break;
            
        case EItemTypePlanRepair:{
            switch (index) {
                case 0:
                    btn.tag = EFilterTypeSourceSystem;//平台监测
                    break;
                case 1:
                    btn.tag = EFilterTypeSourceTour;//巡视报修
                    break;
                default:
                    break;
            }
        }
            
            break;
            
        case EItemTypeSpecialTour:{
            switch (index) {
                case 0:
                    btn.tag = EFilterTypeSourceSystem;//平台监测
                    break;
                case 1:
                    btn.tag = EFilterTypeSourceOther;//其他来源
                    break;
                default:
                    break;
            }
        }
            break;
            
        case EItemTypeTour:{
        }
            
            break;
            
        case EItemTypeFailureTask:{
            switch (index) {
                case 0:
                    btn.tag = EFilterTypeSourceCustomService;//客户
                    break;
                case 1:
                    btn.tag = EFilterTypeSourceSpecialTour;//特巡
                    break;
                default:
                    break;
            }
        }
            
            break;
            
        default:
            break;
    }
}

//创建未确认按钮
-(void)createUnConfirmBtn{
        _unConfirmBtn = [[UIButton alloc]init];
        [_unConfirmBtn setTitle:[self.filterTitles lastObject] forState:UIControlStateNormal];
        [_unConfirmBtn setTitleColor:[UIColor colorWithHexString:@"eebe93"] forState:UIControlStateNormal];
        [_unConfirmBtn setBackgroundImage:[UIImage imageNamed:@"selectBg"] forState:UIControlStateSelected];
        [_unConfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _unConfirmBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
        [_unConfirmBtn addTarget:self action:@selector(filterSource:) forControlEvents:UIControlEventTouchDown];
        _unConfirmBtn.tag = EFilterTypeSourceUnConfirm;
        [self addSubview:_unConfirmBtn];
    //    unConfirmbtn.backgroundColor = [UIColor redColor];
        setViewBorder(_unConfirmBtn, 0.3);
        setViewCorner(_unConfirmBtn, 3);
}

#pragma mark response event

-(void)filterSource:(UIButton *)button{
    button.selected = !button.selected;
    if (button != _currentSelectBtn) {
        self.currentSelectBtn.selected = NO;
        self.currentSelectBtn = button;
    }
    if (self.myBlock) {
        self.myBlock(button.tag,self.parentIndex,button.selected);
    }
}

//筛选未确认工单
-(void)filterUnConfirmTask:(UIButton *)btn{
    
}

#pragma mark - get / set

-(UIButton *)currentSelectBtn{
    if (_currentSelectBtn == nil) {
        _currentSelectBtn = [[UIButton alloc]init];
    }
    return _currentSelectBtn;
}
-(NSMutableArray *)lines{
    if (_lines == nil) {
        _lines = [NSMutableArray arrayWithCapacity:10];
    }
    return _lines;
}

-(NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray arrayWithCapacity:10];
    }
    return _btns;
}

@end

