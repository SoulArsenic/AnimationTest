//
//  NSObject+NSString_DBC.m
//  PinQu
//
//  Created by admin on 14-11-6.
//  Copyright (c) 2014年 daniel. jiang. All rights reserved.
//

#import "NSString+NSString_DBC.h"

@implementation NSString (NSString_DBC)
- (NSMutableString *)covertedToFull{
    NSMutableString *convertedString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformHiraganaKatakana, false);
    return convertedString;
}

-(NSMutableString *)covertedToHalf{
    NSMutableString *convertedString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)convertedString, NULL, kCFStringTransformFullwidthHalfwidth, false);
    return convertedString;
}
@end
