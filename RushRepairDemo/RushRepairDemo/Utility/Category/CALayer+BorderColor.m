//
//  CALayer+BorderColor.m
//  Demo
//
//  Created by Dale on 16/7/25.
//  Copyright © 2016年 Dale. All rights reserved.
//

#import "CALayer+BorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (BorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

@end

