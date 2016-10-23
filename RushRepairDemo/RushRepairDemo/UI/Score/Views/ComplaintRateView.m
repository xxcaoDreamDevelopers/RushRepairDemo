//
//  ComplaintRateView.m
//  MPP
//
//  Created by 齐云 on 16/7/14.
//  Copyright © 2016年 MobileArtisan. All rights reserved.
//

#import "ComplaintRateView.h"
#import "UIColor+HEX.h"

@implementation ComplaintRateView

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //    CGContextAddRect(context, self.frame);
    //    [[UIColor clearColor] setFill];
    //    CGContextDrawPath(context, kCGPathFill);
    
    //灰色的圆
    CGFloat arcX = rect.size.width / 2;
    CGFloat arcY = rect.size.height / 2;
    CGFloat arcRadius = self.frame.size.height / 2 - 20;
    
    CGContextAddArc(context, arcX, arcY - 5, arcRadius, 0, 2*M_PI, 0);
    CGContextSetLineWidth(context, 3);
    [ColorHEX(@"#f4f4f5") setStroke];
    CGContextDrawPath(context, kCGPathStroke);
    
    CGFloat redStartAgnle = -M_PI_2;
    CGFloat redEndAngle = 2 * M_PI / 100 * 20 - M_PI_2;
    //红色的圆
    CGContextAddArc(context, arcX, arcY - 5, arcRadius, redStartAgnle, redEndAngle, 0);
    CGContextSetLineWidth(context, 3);
    [ColorHEX(@"#ff5b36") setStroke];
    CGContextDrawPath(context, kCGPathStroke);
}


@end
