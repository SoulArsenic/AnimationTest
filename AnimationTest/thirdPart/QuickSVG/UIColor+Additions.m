//
//  UIColor+Additions.m
//  QuickCue
//
//  Created by Matthew Newberry on 9/25/12.
//  Copyright (c) 2012 Quickcue. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(CGFloat) alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
	
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert withAlpha:(CGFloat)alpha{
	
	NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
	
	unsigned hexNum;
	if (![scanner scanHexInt:&hexNum]) return nil;
	
	return [UIColor colorWithRGBHex:hexNum alpha:alpha];
}

@end
