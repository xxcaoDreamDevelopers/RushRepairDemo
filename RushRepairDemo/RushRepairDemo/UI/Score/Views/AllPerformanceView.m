//
//  AllPerformanceView.m
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "AllPerformanceView.h"
#import "UIColor+HEX.h"

@implementation AllPerformanceView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    //透明背景
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, self.frame);
    [[UIColor clearColor] setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    //灰色的圆
    CGFloat arcX = rect.size.width / 2;
    CGFloat arcY = rect.size.height / 2;
    CGFloat arcRadius = self.frame.size.width / 2 - 6;

    CGContextAddArc(context, arcX, arcY, arcRadius, 0, 2*M_PI, 0);
    CGContextSetLineWidth(context, 3);
    [ColorHEX(@"#79c8fe") setStroke];
    CGContextDrawPath(context, kCGPathStroke);

    CGFloat redStartAgnle = -M_PI_2;
    CGFloat redEndAngle = 2 * M_PI / 100 * 70 - M_PI_2;
    //红色的圆
    CGContextAddArc(context, arcX, arcY, arcRadius, redStartAgnle, redEndAngle, 0);
    CGContextSetLineWidth(context, 3);
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathStroke);

}


@end
