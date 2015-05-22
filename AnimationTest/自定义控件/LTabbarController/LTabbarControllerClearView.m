//
//  LTabbarControllerClearView.m
//  AnimationTest
//
//  Created by lengbinbin on 15/5/22.
//  Copyright (c) 2015年 lengbinbin. All rights reserved.
//

#import "LTabbarControllerClearView.h"

@implementation LTabbarControllerClearView

//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//    
//    CGFloat locations[3] = { 0.0f, 0.5f, 1.0f };
//    CFArrayRef colors = (__bridge CFArrayRef)@[
//                                               (__bridge id)[UIColor clearColor].CGColor,
//                                               (__bridge id)[UIColor clearColor].CGColor,
//                                               (__bridge id)self.superview.backgroundColor.CGColor
//                                               ];
//    
//    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, colors, locations);
//    
//    CGPoint center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
//    __unused CGFloat radius = MIN(rect.size.width/2, rect.size.height/2);
//    CGContextDrawRadialGradient(context, gradient, center, 0, center, 0, kCGGradientDrawsAfterEndLocation);
//    
//    CGGradientRelease(gradient);
//    CGColorSpaceRelease(colorSpace);
//}
//
@end
