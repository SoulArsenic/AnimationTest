//
//  UIColor+Additions.h
//  QuickCue
//
//  Created by Matthew Newberry on 9/25/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat) alpha;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha;

@end
