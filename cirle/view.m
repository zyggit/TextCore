//
//  view.m
//  cirle
//
//  Created by zyg on 2017/7/12.
//  Copyright © 2017年 zyg. All rights reserved.
//

#import "view.h"

@implementation view

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 116.43, 56.56);
    CGContextRotateCTM(context, -90 * M_PI / 180);
    
    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(-26.94, 0.07)];
    [bezierPath addLineToPoint: CGPointMake(-0.94, 14.07)];
    [bezierPath addCurveToPoint: CGPointMake(18.06, 0.07) controlPoint1: CGPointMake(-0.94, 14.07) controlPoint2: CGPointMake(18.06, 18.6)];
    [bezierPath addCurveToPoint: CGPointMake(-0.94, -12.93) controlPoint1: CGPointMake(18.06, -18.47) controlPoint2: CGPointMake(-0.94, -12.93)];
    [bezierPath addLineToPoint: CGPointMake(-26.94, 0.07)];
    [[UIColor redColor] setFill];
    [bezierPath fill];
    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 1;
    [bezierPath stroke];
    
    CGContextRestoreGState(context);
}
@end
