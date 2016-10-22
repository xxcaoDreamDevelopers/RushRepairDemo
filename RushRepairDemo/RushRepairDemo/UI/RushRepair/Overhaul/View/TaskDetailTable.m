//
//  TaskDetailTable.m
//  IOVS
//
//  Created by UPBest_iOS_1 on 16/9/30.
//  Copyright © 2016年 AKASHA. All rights reserved.
//

#import "TaskDetailHeader.h"
#import "TaskDetailFooter.h"
#import "NewTaskDetailFooter.h"
#import "TaskDetailTable.h"
#import "TaskModel.h"
//表高度
#define TableWidth 340
//把手高度
#define KnobWidth 28
//标题栏
#define TitleViewWidth 92
//收起y
#define HideSelfX TitleViewWidth - TableWidth
//隐藏中心
#define HideSelfCenterY (TitleViewWidth + KnobWidth) - (TableWidth + KnobWidth) / 2
//展开中心
#define ShowSelfCenterY TitleViewWidth + (TableWidth + KnobWidth) / 2
@interface TaskDetailTable() {
    CGFloat _beginPointY;
    TaskModel *_taskModel;
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) TaskDetailFooter *detailFooter;
@property (nonatomic, strong) NewTaskDetailFooter *unreceiveDetailFooter;
@property (nonatomic, assign) CGFloat tableWidth;
@property (nonatomic, assign) CGFloat hideSelfX;
@property (nonatomic, assign) CGFloat hideSelfCenterY;
@property (nonatomic, assign) CGFloat showSelfCenterY;
@property (nonatomic, strong) TaskDetailHeader *detailHeader;

@end
@implementation TaskDetailTable
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(instancetype)initWithTaskModel:(TaskModel *)taskModel tableWidth:(CGFloat)tableWidth{
    if (self = [super init]) {
        _taskModel = taskModel;
        
        self.tableWidth = tableWidth;
        self.hideSelfX = TitleViewWidth - tableWidth;
        self.hideSelfCenterY  = (TitleViewWidth + KnobWidth) - (tableWidth + KnobWidth) / 2;
        self.showSelfCenterY = TitleViewWidth + (tableWidth + KnobWidth) / 2;
        //1.创建尾部
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_introduce"]];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.equalTo(@28);
        }];
        _imageView = imageView;
        
        
        //2.创建按钮
        UIButton *btn = [[UIButton alloc]init];
        [btn addTarget:self action:@selector(upOrDown) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
        [imageView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(imageView);
            make.centerY.equalTo(imageView).offset(-5);
            make.width.equalTo(@94);
            make.height.equalTo(@50);
        }];
        _btn = btn;
        
        //3.创建tableview
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(tableWidth));
            make.bottom.equalTo(imageView.mas_top);
        }];
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(drag:)];
        [self addGestureRecognizer:pan];
        
        
        
        [self change:taskModel];
        
        CGFloat headerHeight;
        if (is40inch) {
            headerHeight = 90;
        }else {
            headerHeight = 102;
        }
        TaskDetailHeader *header = [[TaskDetailHeader alloc]initWithTaskType:taskModel.taskType deviceType:taskModel.deviceType];
        header.frame = CGRectMake(0, 0, self.frame.size.width, headerHeight);
        header.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = header;
        _detailHeader = header;
    }
    return self;
}
#pragma mark - private method

-(void)upOrDown{
    if (self.center.y < 0) { //弹出工单详情
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = CGRectMake(0, TitleViewWidth, self.frame.size.width, self.tableWidth + KnobWidth);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _btn.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }];
        
        if (self.HideOrShowBlock) {
            self.HideOrShowBlock(YES);
        }


    }else { //回到原处
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = CGRectMake(0,  self.hideSelfX, self.frame.size.width, self.tableWidth + KnobWidth);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                _btn.transform = CGAffineTransformIdentity;
            }];
        }];
        

        if (self.HideOrShowBlock) {
            self.HideOrShowBlock(NO);
        }
    }
    

    

    
    

}

-(void)drag:(UIPanGestureRecognizer *)panGesture{
    CGPoint translatedPoint = [panGesture translationInView:self];
    
    CGFloat y = panGesture.view.center.y + translatedPoint.y;
    
    
    //记录开始位置
    
    if (panGesture.state == UIGestureRecognizerStateBegan) {
        _beginPointY = panGesture.view.center.y;
    }
    
    if (panGesture.state == UIGestureRecognizerStateChanged) {
        if (y > self.showSelfCenterY || y < self.hideSelfCenterY) {
            return;
        }
        panGesture.view.center = CGPointMake(panGesture.view.center.x, y);
        [panGesture setTranslation:CGPointMake(0, 0) inView:self];
    }
    




    
    if (panGesture.state == UIGestureRecognizerStateEnded) {
        if (_beginPointY < 0) {//未展开
            if (y > -160) {//弹出工单详情

                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    self.frame = CGRectMake(0, TitleViewWidth, self.frame.size.width, self.tableWidth + KnobWidth);
                } completion:^(BOOL finished) {
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        _btn.transform = CGAffineTransformMakeRotation(M_PI);
                    }];
                    
                }];
                
                
                if (self.HideOrShowBlock) {
                    self.HideOrShowBlock(YES);
                }

            }else { //回到原处
                
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                     self.frame = CGRectMake(0,  self.hideSelfX, self.frame.size.width, self.tableWidth + KnobWidth);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.3 animations:^{
                        _btn.transform = CGAffineTransformIdentity;
                    }];
                }];
                if (self.HideOrShowBlock) {
                    self.HideOrShowBlock(NO);
                }

            }
        }
        
        else { //已展开
                if (y < 300) {//回到原处
                    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.frame = CGRectMake(0,  self.hideSelfX, self.frame.size.width, self.tableWidth + KnobWidth);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _btn.transform = CGAffineTransformIdentity;
                        }];
                    }];
 
                    if (self.HideOrShowBlock) {
                        self.HideOrShowBlock(NO);
                    }
                    
                }else { //弹出工单详情
                    
                    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                        self.frame = CGRectMake(0, TitleViewWidth, self.frame.size.width, self.tableWidth + KnobWidth);
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:0.3 animations:^{
                            _btn.transform = CGAffineTransformMakeRotation(M_PI);
                        }];
                    }];

                }
        }

    }
}
#pragma mark - get / set


-(void)setButtonClickBlock:(void (^)(NSUInteger))ButtonClickBlock{
    _ButtonClickBlock = ButtonClickBlock;
   
    
    if (_taskModel.taskType == ETaskTypeUnreceive) {
        _unreceiveDetailFooter.ButtonClickBlock = ButtonClickBlock;
    }else if (_taskModel.taskType == ETaskTypeUndo) {
         _detailFooter.ButtonClickBlock = ButtonClickBlock;
    }else if (_taskModel.taskType == ETaskTypeFailure) {
        _unreceiveDetailFooter.ButtonClickBlock = ButtonClickBlock;
    }
}

#pragma mark - public method
-(void)hideDetail {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectMake(0,  self.hideSelfX, self.frame.size.width, self.tableWidth + KnobWidth);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            _btn.transform = CGAffineTransformIdentity;
        }];
    }];
}

-(void)setTaskModel:(TaskModel *)taskModel{
    _taskModel = taskModel;
    [_tableView.tableFooterView removeFromSuperview];
    _detailHeader.taskType = taskModel.taskType;
    [self change:taskModel];
    
}

-(void)change:(TaskModel *)taskModel{
    switch (taskModel.taskType) {
        case ETaskTypeUnreceive:{
            NewTaskDetailFooter *footer = [[NewTaskDetailFooter alloc]initWithFrame:CGRectMake(0, 0, 20, 66)];
            footer.ButtonClickBlock = self.ButtonClickBlock;
            footer.backgroundColor = [UIColor whiteColor];
            _tableView.tableFooterView = footer;
            _unreceiveDetailFooter = footer;
        }
            
            
            break;
        case ETaskTypeUndo:{
            TaskDetailFooter *footer = [[TaskDetailFooter alloc]initWithFrame:CGRectMake(0, 0, 20, 66)];
            footer.ButtonClickBlock = self.ButtonClickBlock;
            footer.backgroundColor = [UIColor whiteColor];
            _tableView.tableFooterView = footer;
            _detailFooter = footer;
            
        }
            
            break;
        case ETaskTypeUnConfirm:{
            
            
        }
            
            break;
        case ETaskTypeFailure:{
            NewTaskDetailFooter *footer = [[NewTaskDetailFooter alloc]initWithFrame:CGRectMake(0, 0, 20, 66)];
            footer.ButtonClickBlock = self.ButtonClickBlock;
            footer.backgroundColor = [UIColor whiteColor];
            _tableView.tableFooterView = footer;
            _unreceiveDetailFooter = footer;
            
        }
            
            break;
            
        default:
            break;
    }
}
@end










