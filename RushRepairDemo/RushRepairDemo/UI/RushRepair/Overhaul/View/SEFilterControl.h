//
//  SEFilterControl.h
//  DBSlideButtonControl
//
//  Created by Jdb on 16/3/26.
//  Copyright © 2016年 uimbank. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SEFilterKnob.h"
@interface SEFilterControl : UIControl
-(id) initWithFrame:(CGRect) frame Titles:(NSArray *) titles taskNumbers:(NSArray *)taskNumbers;
-(void) setSelectedIndex:(int)index;
-(void) setTitlesFont:(UIFont *)font;

@property(nonatomic, strong) UIButton *handler;
@property(nonatomic, strong) UIColor *progressColor;
@property(nonatomic, strong) UIColor *TopTitlesColor;
@property(nonatomic, readonly) int SelectedIndex;
@property(nonatomic, strong) NSMutableArray *numLabArray;
@property(nonatomic, strong) NSMutableArray *taskNumberArray;//工单数量
@end
